import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view_model/providers/reset_password_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';

class EnterUserName extends StatelessWidget {
  const EnterUserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ResetPasswordProvider resetPasswordProvider =
        Provider.of<ResetPasswordProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
              ]),
              SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.9,
                child: Image.asset(AssetPath.logoPath),
              ),
              SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.9,
                child: Text(
                  "Enter your phone",
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
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: resetPasswordProvider.textPhone.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  resetPasswordProvider.clearPhoneController(),
                            )
                          : null,
                      labelText: "Your Phone",
                      fillColor: Colors.grey,
                      errorText: resetPasswordProvider.submitValid
                          ? resetPasswordProvider.phone.error
                          : null),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: resetPasswordProvider.phoneController,
                  onChanged: (String value) {
                    resetPasswordProvider.checkPhone(value);
                  },
                  focusNode: resetPasswordProvider.phoneFocus,
                  onEditingComplete: () {
                    resetPasswordProvider.changeFocus(context, 'phone');
                  },
                ),
              ),
              SizedBox(
                  width: size.width * 0.9,
                  child: ButtonDefault(
                      content: "Next",
                      voidCallBack: () {
                        resetPasswordProvider.submitUsername(context);
                      })),
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
