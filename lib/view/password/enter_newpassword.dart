import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view_model/providers/enter_change_password_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';

class EnterChangePassword extends StatelessWidget {
  const EnterChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterChangePasswordProvider provider =
        Provider.of<EnterChangePasswordProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
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
                      obscureText: true,
                      onEditingComplete: () {
                        provider.nodeNewPassword.requestFocus();
                      },
                      onChanged: (String value) {
                        provider.checkPassword(value);
                      }),
                ),
                SizedBox(
                  height: size.height * 0.18,
                  width: size.width * 0.9,
                  child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'New Password',
                          ),
                      focusNode: provider.nodeNewPassword,
                      obscureText: true,
                      onEditingComplete: () {
                        provider.nodeNewPassword.unfocus();
                        provider.submit(context);
                      },
                      onChanged: (String value) {
                        provider.checkNewPassword(value);
                      }),
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Submit",
                        voidCallBack: () {
                          provider.submit(context);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
