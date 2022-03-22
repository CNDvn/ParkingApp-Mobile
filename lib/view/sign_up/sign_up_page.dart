import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view_model/auth.dart';
import 'package:parkingappmobile/view_model/providers/sign_up_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/input_date/input_date.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SignUpProvider signUpProvider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40.0),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                      child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                    onPressed: ()async {
                      final AuthBase auth = Auth();
                      auth.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                    },
                  )),
                ]),
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.9,
                  child: Image.asset(AssetPath.logoPath),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textPhone.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearPhoneController(),
                              )
                            : null,
                        labelText: "Phone number",
                        fillColor: Colors.grey,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.phone.error
                            : null),
                    autofocus: false,
                    controller: signUpProvider.phoneController,
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "phone");
                    },
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "phone");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textPassword.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => signUpProvider
                                        .clearPasswordController(),
                                  ),
                                  IconButton(
                                      icon: signUpProvider.isPasswordVariable
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () => signUpProvider
                                          .changePasswordVariable()),
                                ],
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.password.error
                            : null,
                        labelText: "Password",
                        fillColor: Colors.grey),
                    autofocus: false,
                    obscureText: signUpProvider.isPasswordVariable,
                    controller: signUpProvider.passwordController,
                    focusNode: signUpProvider.passwordFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "password");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "password");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textFirstName.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearFirstNameController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.firstName.error
                            : null,
                        labelText: "First Name",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.firstNameController,
                    focusNode: signUpProvider.firstNameFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "firstName");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "firstName");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textLastName.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearLastNameController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.lastName.error
                            : null,
                        labelText: "Last Name",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.lastNameController,
                    focusNode: signUpProvider.lastNameFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "lastName");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "lastName");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textEmail.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearEmailController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.email.error
                            : null,
                        labelText: "Email",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.emailController,
                    focusNode: signUpProvider.emailFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "email");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "email");
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: InputDate(provider: signUpProvider),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: signUpProvider.textAddress.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearAddressController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.address.error
                            : null,
                        labelText: "Address",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.addressController,
                    focusNode: signUpProvider.addressFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "address");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "address");
                    },
                  ),
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Submit",
                        voidCallBack: () {
                          signUpProvider.submitData(context);
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
