import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
import 'package:parkingappmobile/view/viewPark/view_park.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => const RootPage(),
    "/SignInPage": (context) => const SignInPage(),
    "/ViewPark": (context) => const ViewPark()
  };
}
