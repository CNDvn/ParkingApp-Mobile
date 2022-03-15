import 'package:flutter/material.dart';
import 'package:parkingappmobile/repository/impl/bookign_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class ParkingDetailsProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String parkingName = "";
  String phoneNumber = "";
  String timeCheckIn = "";
  String address = "";
  String startTime ="";

  addInformation(String parkingName, String phoneNumber, String address) async {
    this.parkingName = parkingName;
    this.phoneNumber = phoneNumber;
    this.address = address;
    secureStorage.writeSecureData("parkingName", parkingName);
    secureStorage.writeSecureData("phoneNumber", phoneNumber);
    secureStorage.writeSecureData("address", address);
    notifyListeners();
  }

  booKingParking(BuildContext context) async{
    String idParking =await secureStorage.readSecureData("idParking");
    String idCar = await secureStorage.readSecureData("idCar");
    String accessToken = await secureStorage.readSecureData("token");
    String url = "https://parking-app-project.herokuapp.com/api/v1/bookings/parking/$idParking/car/$idCar";
    BookingRepImpl().postBooking(url, accessToken).then((value) {
      if (value.statusCode == 201){
        startTime = value.result!.startTime.toString();
      showDialogCustom(context);
      Navigator.pushReplacementNamed(context, "/TrackingCar");
      }
      
    });
  }
}
