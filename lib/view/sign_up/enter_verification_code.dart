import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view/sign_up/enter_password.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class EnterVerificationCode extends StatelessWidget {
  const EnterVerificationCode({Key? key}) : super(key: key);

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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),
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
                          ],
                        )),
                  ),
                  onCompleted: (String value) {},
                  onEditing: (bool value) {},
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Next",
                        voidCallBack: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EnterPassword()),
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
