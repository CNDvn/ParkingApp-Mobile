import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/bookParking/book_space.dart';
import 'package:parkingappmobile/view/bookParking/select_parking_space.dart';
import 'package:parkingappmobile/view/bookParking/successful_booking.dart';
import 'package:parkingappmobile/view/bookParking/tracking_car.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view/bookParking/booking_details.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/qr_code/qr_code.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/view/sign_up/sign_up_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view/viewPark/view_park.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Welcome(),
    // "/": (context) => const SignInPage(),    
    //SignUp
    "/SignUpPage": (context) => const SignUpPage(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/EnterVerificationCode": (context) => const EnterVerificationCode(),
    //Map
    "/": (context) => const BottomTabBar(),
    "/UserProfile": (context) => const UserProfile(),
    "/ViewPark": (context) => const ViewPark(),
    "/TrackingCar": (context) => const TrackingCar(),
    "/QRCodePage": (context) => const QRCodePage(),
    //Parking
    //Booking
    "/BookSpace": (context) => const BookSpace(),
    "/BookingDetails": (context) => const BookingDetails(),
    "/SelectParkingSpace": (context) => const SelectParkingSpace(),
    "/SuccessfulBooking": (context) => const SuccessfulBooking()
  };
}
