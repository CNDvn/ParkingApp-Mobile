import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class ProtectRouting extends StatefulWidget {
  const ProtectRouting({Key? key}) : super(key: key);

  @override
  _ProtectRoutingState createState() => _ProtectRoutingState();
}

class _ProtectRoutingState extends State<ProtectRouting> {
  final SecureStorage secureStorage = SecureStorage();
  String token = "";
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  Future<void> _startApp() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    if (token == null) {
      Navigator.pushReplacementNamed(context, "/SignInPage");
    } else {
      Navigator.pushReplacementNamed(context, "/BottomTabBar");
      // TODO Navigate to Home Screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splashscreen"),
      ),
    );
  }
}
