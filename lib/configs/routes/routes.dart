import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view/bookParking/booking_details.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/view/sign_up/enter_phone_number.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view/viewPark/view_park.dart';
import 'package:parkingappmobile/view/welcome/welcome.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Welcome(),
    "/SignInPage": (context) => const SignInPage(),
    "/userProfile": (context) => const UserProfile(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/EnterPhoneNumber": (context) => const EnterPhoneNumber(),
    "/EnterVerificationCode": (context) => const EnterVerificationCode(),
    "/": (context) => const BottomTabBar(),
    "/ViewPark": (context) => const ViewPark(),
    "/BookingDetails": (context) => const BookingDetails()
  };
}
