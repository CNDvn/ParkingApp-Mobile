import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/bookParking/tracking_car.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view/bookParking/booking_details.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/my_car/qrcode_mycar.dart';
import 'package:parkingappmobile/view/password/enter_newpassword.dart';
import 'package:parkingappmobile/view/promotion/promotion.dart';
import 'package:parkingappmobile/view/protect/protect_routing.dart';
import 'package:parkingappmobile/view/qr_code/qr_code.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/view/sign_up/sign_up_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Welcome(),
    "/SignInPage": (context) => const SignInPage(),
    //SignUp
    "/SignUpPage": (context) => const SignUpPage(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/EnterVerificationCode": (context) => const EnterVerificationCode(),
    //Map
    "/BottomTabBar": (context) => const BottomTabBar(),
    "/UserProfile": (context) => const UserProfile(),
    "/TrackingCar": (context) => const TrackingCar(),
    "/QRCodePage": (context) => const QRCodePage(),
    //Parking
    //Booking
    "/BookingDetails": (context) => const BookingDetails(),
    //Auth
    "/EnterChangePassword": (context) => const EnterChangePassword(),
    //QRCode
    "/QRCodeMyCar": (context) => const QRCodeMyCar(),
    //Promotion
    "/Promotion": (context) => const Promotion(),
    "/": (context) => const ProtectRouting(),
  };
}
