import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
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
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.9,
                  child: Image.asset(AssetPath.logoPath),
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
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: provider.textPassword.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => provider
                                        .clearPasswordController(),
                                  ),
                                  IconButton(
                                      icon: provider.isPasswordVariable
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () => provider
                                          .changePasswordVariable()),
                                ],
                              )
                            : null,
                        labelText: "Password",
                        errorText: provider.clickButtonFlag
                            ? provider.password.error
                            : null),
                    obscureText: provider.isPasswordVariable,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    controller: provider.passwordController,
                    onChanged: (String value) {
                      provider.checkPassword(value);
                    },
                    // focusNode: provider.passwordFocus,
                    // onEditingComplete: () {
                    //   signInProvider.changeFocus(context, 'password');
                    // },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: provider.textNewPassword.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => provider
                                        .clearNewPasswordController(),
                                  ),
                                  IconButton(
                                      icon: provider.isPasswordVariable
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () => provider
                                          .changeNewPasswordVariable()),
                                ],
                              )
                            : null,
                        labelText: "New Password",
                        errorText: provider.clickButtonFlag
                            ? provider.password.error
                            : null),
                    obscureText: provider.isNewPasswordVariable,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    controller: provider.newPasswordController,
                    onChanged: (String value) {
                      provider.checkNewPassword(value);
                    },
                    // focusNode: provider.passwordFocus,
                    // onEditingComplete: () {
                    //   signInProvider.changeFocus(context, 'password');
                    // },
                  ),
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
