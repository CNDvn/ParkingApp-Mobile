import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/routes/routes.dart';
import 'package:parkingappmobile/providers/main_providers/main_providers.dart';
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
      providers: MainProviders.providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking App',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
          initialRoute: "/",
          routes: Routes.routes,
          //home: const RootPage()
          ),
    );
  }
}
