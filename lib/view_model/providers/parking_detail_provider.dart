import 'package:flutter/material.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class ParkingDetailsProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String parkingName = "";
  String phoneNumber = "";
  String timeCheckIn = "";
  String address = "";

  addInformation(String parkingName, String phoneNumber, String address) async {
    this.parkingName = parkingName;
    this.phoneNumber = phoneNumber;
    this.address = address;
    secureStorage.writeSecureData("parkingName", parkingName);
    secureStorage.writeSecureData("phoneNumber", phoneNumber);
    secureStorage.writeSecureData("address", address);
    notifyListeners();
  }
}
