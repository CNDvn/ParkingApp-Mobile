import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/exception/show_alert_dialog.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/repository/impl/payment_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class BookingDetailProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  //parking
  String parkingName = "";
  String phoneNumber = "";
  String address = "";
  //user
  String fullName = "";
  //booking
  String startTime = "";
  String checkInTime = "";
  String price = "";

  bool flag = false;

  getInformation() async {
    parkingName = await secureStorage.readSecureData("parkingName");
    phoneNumber = await secureStorage.readSecureData("phoneNumber");
    address = await secureStorage.readSecureData("address");
    startTime = await secureStorage.readSecureData("bookingTime");
    notifyListeners();
  }

  showDiaLog(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Payment',
        content: 'Are you sure that you want to Payment?',
        defaultActionText: 'Ok',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      payment(context);
    }
  }

  payment(BuildContext context) async {
    String idBooking = await secureStorage.readSecureData("idBooking");
    String url =
        "https://parking-app-project.herokuapp.com/api/v1/payments/booking/$idBooking";
    String accessToken = await secureStorage.readSecureData("token");
    PaymentRepImpl().postPayment(url, accessToken).then((value) {
      if (value.statusCode == 201) {
        showToastSuccess("Payment Successfull");
        changeStatusButton();
      }
    });
  }

  changeStatusButton() {
    flag = true;
    notifyListeners();
  }
}
