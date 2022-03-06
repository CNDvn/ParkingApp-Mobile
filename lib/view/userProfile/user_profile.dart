import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/input_date/input_date.dart';
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
            Row(
              children: [
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.5,
                  child: TextField(
                      decoration: InputDecoration(
                          suffixIcon:
                              provider.firstNameController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          provider.clearFirstNameController(),
                                    )
                                  : null,
                          labelText: 'First name',
                          errorText: provider.clickButtonFlag
                              ? provider.firstName.error
                              : null),
                      autofocus: true,
                      controller: provider.firstNameController,
                      onEditingComplete: () {
                        provider.nodeLastName.requestFocus();
                      },
                      onChanged: (String value) {
                        provider.checkFirstName(value);
                      }),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width - (40 + size.width * 0.55),
                  child: TextField(
                      decoration: InputDecoration(
                          suffixIcon:
                              provider.lastNameController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          provider.clearLastNameController(),
                                    )
                                  : null,
                          labelText: 'Last name',
                          errorText: provider.clickButtonFlag
                              ? provider.lastName.error
                              : null),
                      focusNode: provider.nodeLastName,
                      controller: provider.lastNameController,
                      onEditingComplete: () {
                        provider.nodeEmail.requestFocus();
                      },
                      onChanged: (String value) {
                        provider.checkLastName(value);
                      }),
                ),
              ],
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: provider.emailController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => provider.clearEmailController(),
                          )
                        : null,
                    labelText: 'Email address',
                    errorText:
                        provider.clickButtonFlag ? provider.email.error : null),
                focusNode: provider.nodeEmail,
                controller: provider.emailController,
                onEditingComplete: () {
                  provider.nodePhone.requestFocus();
                },
                onChanged: (value) {
                  provider.checkEmail(value);
                },
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Phone number',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                        height: size.height * 0.105,
                        width: size.width * 0.1,
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              '+84 ',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: size.height * 0.105,
                      width: size.width - (40 + size.width * 0.1),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: provider.phoneController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => provider.phoneController,
                                )
                              : null,
                          errorText: provider.clickButtonFlag
                              ? provider.phone.error
                              : null,
                        ),
                        focusNode: provider.nodePhone,
                        controller: provider.phoneController,
                        onChanged: (value) {
                          provider.checkPhone(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InputDate(provider: provider),
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
