import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class EnterPhoneNumber extends StatelessWidget {
  const EnterPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Container(
            color: AppColor.whiteBackground,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 70),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Text(
                      "Enter your phone number",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.greyText,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.16,
                    width: size.width * 0.9,
                    child: const TextField(
                      decoration: InputDecoration(
                          labelText: "Phone number", fillColor: Colors.grey),
                      autofocus: false,
                    ),
                  ),
                  SizedBox(
                      width: size.width * 0.9,
                      child:
                          ButtonDefault(content: "Next", voidCallBack: () {}))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
