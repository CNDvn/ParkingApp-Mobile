import 'package:flutter/material.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
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
                      "Enter your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.9,
                    child: const TextField(
                      decoration: InputDecoration(
                          labelText: "Password", fillColor: Colors.grey),
                      autofocus: false,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.18,
                    width: size.width * 0.9,
                    child: const TextField(
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          fillColor: Colors.grey),
                      autofocus: false,
                    ),
                  ),
                  SizedBox(
                      width: size.width * 0.9,
                      child: ButtonDefault(
                          content: "Create Account", voidCallBack: () {}))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
