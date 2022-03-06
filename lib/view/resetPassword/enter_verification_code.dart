import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view_model/providers/reset_password_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';

class EnterVerificationCodeReset extends StatefulWidget {
  const EnterVerificationCodeReset({Key? key, 
  required this.username
  }) : super(key: key);

final String username;

  @override
  State<EnterVerificationCodeReset> createState() => _EnterVerificationCodeResetState();
}

class _EnterVerificationCodeResetState extends State<EnterVerificationCodeReset> {
  bool _onEditing = true;
  int otp = 0;
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    ResetPasswordProvider resetPasswordProvider = Provider.of<ResetPasswordProvider>(context);
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
                SizedBox(
                  child: Text(
                    "Enter verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.greyText,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                VerificationCode(
                  onCompleted: (value) {
                    otp = int.parse(value);
                  },
                  textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
                  underlineColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  length: 4,
                  clearAll: Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Didn’t receive code? ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Resend",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[300]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue[300]),
                              ),
                            )
                          ],
                        )),
                  ),
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Next",
                        voidCallBack: () {
                          resetPasswordProvider.submitOtp(context, widget.username, otp);
                        })),
                SizedBox(
                  height: size.height *0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}