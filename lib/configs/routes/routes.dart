import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/bookParking/tracking_car.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view/bookParking/booking_details.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/view/sign_up/sign_up_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view/viewPark/view_park.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Welcome(),
    "/": (context) => const TrackingCar(),
    "/userProfile": (context) => const UserProfile(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/SignUpPage": (context) => const SignUpPage(),
    "/EnterVerificationCode": (context) => const EnterVerificationCode(),
    "/BottomTabBar": (context) => const BottomTabBar(),
    "/ViewPark": (context) => const ViewPark(),
    "/BookingDetails": (context) => const BookingDetails(),
    "/TrackingCar": (context) => const TrackingCar()
  };
}
