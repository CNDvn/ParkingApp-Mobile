import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
        home: const UserProfile());
  }
}
