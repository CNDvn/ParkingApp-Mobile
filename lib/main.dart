import 'package:flutter/material.dart';
import 'package:parkingappmobile/providers/enter_password_provider.dart';
import 'package:parkingappmobile/providers/sign_in_provider.dart';
import 'package:parkingappmobile/providers/user_profile_provider.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/view/sign_up/enter_phone_number.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider(),
        ),
        ChangeNotifierProvider<EnterPasswordProvider>(
          create: (context) => EnterPasswordProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
        initialRoute: "/EnterPassword",
        routes: {
          "/": (context) => const RootPage(),
          "/userProfile": (context) => const UserProfile(),
          "/EnterPassword": (context) => const EnterPassword(),
          "/EnterPhoneNumber": (context) => const EnterPhoneNumber(),
          "/EnterVerificationCode": (context) => const EnterVerificationCode()
        },
        //home: const RootPage()
      ),
    );
  }
}
