import 'package:flutter/material.dart';
import 'package:parkingappmobile/providers/sign_in_provider.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking App',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
          initialRoute: "/",
          routes: {
            "/":(context) =>const RootPage(),
          },
          //home: const RootPage()
          ),
    );
  }
}
