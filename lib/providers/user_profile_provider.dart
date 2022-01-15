import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/regex.dart';

class ValidationItem {
  String value;
  String? error;
  ValidationItem(this.value, this.error);
}

class UserProfileProvider with ChangeNotifier {
  ValidationItem fullName = ValidationItem("", null);
  ValidationItem email = ValidationItem("", null);
  ValidationItem phone = ValidationItem("", null);
  ValidationItem password = ValidationItem("", null);

  bool clickButtonFlag = false;

  FocusNode nodeFullName = FocusNode();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePhone = FocusNode();
  FocusNode nodePassword = FocusNode();

  bool checkFullName(String value) {
    fullName.value = value;
    bool flag = true;
    if (value.isEmpty) {
      fullName.error = "Full name not empty";
      flag = false;
    } else {
      fullName.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkEmail(String value) {
    bool match = RegExp(Regex.email).hasMatch(value);
    bool flag = true;
    email.value = value;
    if (!match) {
      email.error = "Email invalid";
      flag = false;
    } else {
      email.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkPhone(String value) {
    bool flag = true;
    phone.value = value;
    if (value.length != 10) {
      phone.error = "Phone number must have 10 character";
      flag = false;
    } else {
      phone.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkPassword(String value) {
    password.value = value;
    bool flag = true;
    if (value.isEmpty) {
      password.error = "Password not empty";
      flag = false;
    } else {
      password.error = null;
    }
    notifyListeners();
    return flag;
  }

  void submit() {
    clickButtonFlag = true;
    bool isFullName = checkFullName(fullName.value);
    bool isEmail = checkEmail(email.value);
    bool isPhone = checkPhone(phone.value);
    bool isPassword = checkPassword(password.value);
    if (isFullName && isEmail && isPhone && isPassword) {
      print("qua ai");
    }
    notifyListeners();
  }
}
