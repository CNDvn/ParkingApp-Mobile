import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/repository/impl/bookign_rep_impl.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';

class TrackingCarProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String bookingTime = "";
  String parkingTime = "";
  String id = "";
  bool flag = false;

  addInformation(String bookingTime, String parkingTime) async {
    this.bookingTime = bookingTime;
    this.parkingTime = parkingTime;
    notifyListeners();
  }

  insertStorage() {
    secureStorage.writeSecureData("bookingTime", bookingTime);
    secureStorage.writeSecureData("parkingTime", parkingTime);
    notifyListeners();
  }

  checkOut(BuildContext context) async {
    BookingDetailProvider bookingDetailProvider =
        Provider.of<BookingDetailProvider>(context, listen: false);
    String idParking = await secureStorage.readSecureData("idParking");
    String idCar = await secureStorage.readSecureData("idCar");
    String firstNameSto = await secureStorage.readSecureData('firstName');
    String lastNameSto = await secureStorage.readSecureData('lastName');
    String url =
        "${UrlApi.serverPath}/bookings/checkOut/parking/$idParking/car/$idCar";
    String accessToken = await secureStorage.readSecureData("token");
    BookingRepImpl().postCheckOut(url, accessToken).then((value) {
      if (value.statusCode == 201) {
        //parking
        bookingDetailProvider.parkingName =
            value.result!.booking!.parking!.name!;
        bookingDetailProvider.phoneNumber =
            value.result!.booking!.parking!.phoneNumber!;
        bookingDetailProvider.address =
            value.result!.booking!.parking!.address!;
        //user
        bookingDetailProvider.fullName = '$firstNameSto $lastNameSto';
        //booking
        bookingDetailProvider.startTime =
            DateFormat('KK:mm:a').format(value.result!.booking!.startTime!.add(const Duration(hours: 7)));
        bookingDetailProvider.checkInTime =
            DateFormat('KK:mm:a').format(value.result!.booking!.checkinTime!.add(const Duration(hours: 7)));
        bookingDetailProvider.price = value.result!.booking!.price!.split(".").first+" VND/H";
        bookingDetailProvider.amount = value.result!.amount.toString().split(".").first+" VND";
        secureStorage.writeSecureData("idBooking", value.result!.booking!.id!);
        flag = true;
        id = value.result!.id!;
        Navigator.pushReplacementNamed(context, "/BookingDetails");
      }
    });
  }
}
