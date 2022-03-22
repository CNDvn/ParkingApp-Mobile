import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/exception/show_alert_dialog.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/repository/impl/bookign_rep_impl.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
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
    final format = NumberFormat("#,##0,000");
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
        bookingDetailProvider.startTime = DateFormat('KK:mm:a').format(
            value.result!.booking!.startTime!.add(const Duration(hours: 7)));
        bookingDetailProvider.checkInTime = DateFormat('KK:mm:a').format(
            value.result!.booking!.checkinTime!.add(const Duration(hours: 7)));
        bookingDetailProvider.price = format
                .format(double.parse(value.result!.booking!.price!
                    .substring(0, value.result!.booking!.price!.length - 4)))
                .toString() +
            " VND/H";
        bookingDetailProvider.amount = format
                .format(double.parse(value.result!.amount.toString()
                    .substring(0, value.result!.amount.toString().length - 4)))
                .toString() +
            " VND/H";
        secureStorage.writeSecureData("idBooking", value.result!.booking!.id!);
        flag = true;
        id = value.result!.id!;
        showToastSuccess("Check-out Successfull");
        Navigator.pushReplacementNamed(context, "/BookingDetails");
      }
    });
    notifyListeners();
  }

  showDiaLog(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Cancel Booked',
        content: 'Are you sure that you want to Cancel Booked?',
        defaultActionText: 'Ok',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      cancelBook(context);
    }
  }

  cancelBook(BuildContext context) async {
    MyCarProvider myCarProvider =
        Provider.of<MyCarProvider>(context, listen: false);
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: false);
    BookingDetailProvider providerBooking =
        Provider.of<BookingDetailProvider>(context, listen: false);
    myCarProvider.getBookingByIdCar();
    DateTime time = myCarProvider.now;
    String idCar = await secureStorage.readSecureData("idCar");
    String url = '${UrlApi.serverPath}/bookings/cancel/car/$idCar';
    String accessToken = await secureStorage.readSecureData("token");
    if (time.minute < 2) {
      if (time.hour == 0) {
        BookingRepImpl().putBookCancelByIdCar1(url, accessToken).then((value) {
          myCarProvider.listMyCarNoActive.remove(myCarProvider.firstCarBooked);
          myCarProvider.firstCarBooked = "";
          myCarProvider.resetAfterPay();
          mapProvider.reset();
          Navigator.pushNamedAndRemoveUntil(
              context, "/BottomTabBar", (route) => false);
        });
      }
    } else {
      if (time.second > 0) {
        BookingRepImpl()
            .putBookCancelByIdCar(url, accessToken)
            .then((value) async {
          secureStorage.writeSecureData("idBooking", value.result!.id!);
          providerBooking.payment(context);
          final didrequestPayment = await showAlertDialog(context,
              title: "Payment",
              content: "You have run out of free time!!!"
                  "Total Price: ${value.result!.payment!.amount}"
                  "End Time: ${value.result!.payment!.endTime}",
              defaultActionText: "Ok");
          if (didrequestPayment == true) {
            myCarProvider.listMyCarNoActive
                .remove(myCarProvider.firstCarBooked);
            myCarProvider.firstCarBooked = "";
            myCarProvider.resetAfterPay();
            mapProvider.reset();
            Navigator.pushNamedAndRemoveUntil(
                context, "/BottomTabBar", (route) => false);
          }
        });
      } else {
        BookingRepImpl().putBookCancelByIdCar1(url, accessToken).then((value) {
          myCarProvider.listMyCarNoActive.remove(myCarProvider.firstCarBooked);
          myCarProvider.firstCarBooked = "";
          myCarProvider.resetAfterPay();
          mapProvider.reset();
          Navigator.pushNamedAndRemoveUntil(
              context, "/BottomTabBar", (route) => false);
        });
      }
    }
  }
}
