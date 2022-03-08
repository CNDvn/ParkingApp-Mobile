import 'package:flutter/material.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class BookingDetailProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String parkingName = "";
  String phoneNumber = "";
  String timeCheckIn = "";
  String address = "";
  String bookingTime = "";
  String parkingTime = "";
  String promotion = "";
  String total = "";
  String timeCheckOut = "";

  getInformation () async {
    parkingName = await secureStorage.readSecureData("parkingName");
    phoneNumber = await secureStorage.readSecureData("phoneNumber");
    address = await secureStorage.readSecureData("address");
    bookingTime = await secureStorage.readSecureData("bookingTime");
    parkingTime = await secureStorage.readSecureData("parkingTime");
    // promotion = await secureStorage.readSecureData("promotion");    
    notifyListeners();
  }
}