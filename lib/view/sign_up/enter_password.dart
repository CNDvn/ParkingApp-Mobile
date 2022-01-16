import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/providers/enter_password_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterPasswordProvider provider =
        Provider.of<EnterPasswordProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: Container(
              color: AppColor.whiteBackground,
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
                            color: AppColor.greyText,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.9,
                      child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              errorText: provider.clickButtonFlag
                                  ? provider.password.error
                                  : null),
                          autofocus: true,
                          onEditingComplete: () {
                            provider.nodeConfirmPassword.requestFocus();
                          },
                          onChanged: (String value) {
                            provider.checkPassword(value);
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.18,
                      width: size.width * 0.9,
                      child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              errorText: provider.clickButtonFlag
                                  ? provider.confirmPassword.error
                                  : null),
                          focusNode: provider.nodeConfirmPassword,
                          onEditingComplete: () {
                            provider.nodeConfirmPassword.unfocus();
                            provider.submit();
                          },
                          onChanged: (String value) {
                            provider.checkConfirmPassword(value);
                          }),
                    ),
                    SizedBox(
                        width: size.width * 0.9,
                        child: ButtonDefault(
                            content: "Create Account",
                            voidCallBack: () {
                              provider.submit();
                            }))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
