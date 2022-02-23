import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileProvider provider = Provider.of<UserProfileProvider>(context);
    Size size = MediaQuery.of(context).size;
    double sizeHeightInput = size.height * 0.12;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  const Expanded(
                    flex: 6,
                    child: Text(
                      "User Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100 / 2),
                    child: Image.asset(
                      AssetPath.profilePhoto,
                      height: 100.0,
                      width: 100.0,
                    ))),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Full name',
                      errorText: provider.clickButtonFlag
                          ? provider.fullName.error
                          : null),
                  autofocus: true,
                  controller: provider.fullNameController,
                  onEditingComplete: () {
                    provider.nodeEmail.requestFocus();
                  },
                  onChanged: (String value) {
                    provider.checkFullName(value);
                  }),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email address',
                    errorText:
                        provider.clickButtonFlag ? provider.email.error : null),
                focusNode: provider.nodeEmail,
                onEditingComplete: () {
                  provider.nodePhone.requestFocus();
                },
                onChanged: (value) {
                  provider.checkEmail(value);
                },
              ),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Phone number',
                    errorText:
                        provider.clickButtonFlag ? provider.phone.error : null),
                focusNode: provider.nodePhone,
                onEditingComplete: () {
                  provider.nodePassword.requestFocus();
                },
                onChanged: (value) {
                  provider.checkPhone(value);
                },
              ),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: provider.clickButtonFlag
                        ? provider.password.error
                        : null),
                focusNode: provider.nodePassword,
                onChanged: (value) {
                  provider.checkPassword(value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height * 0.07, 0, 0),
              child: ButtonDefault(
                width: size.width,
                content: 'Save',
                voidCallBack: () => {provider.submit()},
              ),
            )
          ],
        ),
      )),
    );
  }
}
