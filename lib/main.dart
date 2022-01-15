import 'package:flutter/material.dart';
import 'package:parkingappmobile/providers/enter_password_provider.dart';
import 'package:parkingappmobile/providers/sign_in_provider.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
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
          "/EnterPassword": (context) => const EnterPassword(),
        },
        //home: const RootPage()
      ),
    );
  }
}
