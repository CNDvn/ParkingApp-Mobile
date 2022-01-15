import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';

import 'package:parkingappmobile/view/sign_up/enter_phone_number.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text("Root Page"),
      // ),
      // body: Column(
      //   children: [Image.asset(AssetPath.posterCity)],
      // ),
      // body: EnterPhoneNumber(),
      // body: EnterVerificationCode(),
      body: EnterPassword(),
    );
  }
}
