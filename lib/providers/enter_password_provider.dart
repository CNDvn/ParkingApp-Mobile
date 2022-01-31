import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';

class ValidationPassword {
  String value;
  String? error;
  ValidationPassword(this.value, this.error);
}

class EnterPasswordProvider with ChangeNotifier {
  ValidationPassword password = ValidationPassword("", null);
  ValidationPassword confirmPassword = ValidationPassword("", null);

  bool clickButtonFlag = false;
  FocusNode nodePassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();

  bool checkPassword(String value) {
    password.value = value;
    bool flag = true;
    if (value.trim().isEmpty) {
      password.error = "Password is not empty";
      flag = false;
    } else {
      password.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkConfirmPassword(String value) {
    confirmPassword.value = value;
    bool flag = true;
    if (value.trim().isEmpty) {
      confirmPassword.error = "Confirm password is not empty";
      flag = false;
    } else if (value != password.value) {
      confirmPassword.error =
          "Confirm password does not match the entered password ";
    } else {
      confirmPassword.error = null;
    }
    notifyListeners();
    return flag;
  }

  void submit(BuildContext context) {
    clickButtonFlag = true;
    bool isPassword = checkPassword(password.value);
    bool isConfirmPassword = checkConfirmPassword(confirmPassword.value);

    if (isPassword && isConfirmPassword) {}
    Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInPage()),
          (route) => false);
    notifyListeners();
  }
}
