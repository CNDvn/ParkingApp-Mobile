import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class TrackingCarProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String bookingTime = "";
  String parkingTime = "";

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
}
