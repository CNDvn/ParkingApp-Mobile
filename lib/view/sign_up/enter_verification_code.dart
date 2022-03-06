import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/model/request/verify_otp_req.dart';
import 'package:parkingappmobile/repository/impl/verify_otp_sign_up_impl.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class EnterVerificationCode extends StatefulWidget {
  const EnterVerificationCode({Key? key}) : super(key: key);

  @override
  State<EnterVerificationCode> createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterVerificationCode> {
  var _codeNumber = 0;
  bool _onEditing = true;

  // ignore: prefer_function_declarations_over_variables
  final handleSubmit = (int tmp, BuildContext context) {
    log("hello");
    final data = VerifyOtpSignUpReq(otp: tmp);
    showDialogCustom(context);
    VerifyOTPRepImpl()
        .postVerifyOTPSignUp(UrlApi.verifyOTPPath, data)
        .then((value) => {
              showToastSuccess(value.result!),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              )
            })
        .catchError((onError) {
      log(onError.toString());
      Navigator.pushReplacementNamed(context, "/EnterVerificationCode");
    });
  };

  @override
  Widget build(BuildContext context) {
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
                  textStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.black),
                  underlineColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  length: 4,
                  clearAll: Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
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
                  onCompleted: (String value) {
                    _codeNumber = int.parse(value);
                  },
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
                        content: "Submit",
                        voidCallBack: () {
                          handleSubmit(_codeNumber, context);
                        })),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
