import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/welcome/welcome.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => const Welcome(),
    "/SignInPage": (context) => const SignInPage()
  };
}
