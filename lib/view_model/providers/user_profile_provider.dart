import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/constants/regex.dart';
import 'package:parkingappmobile/model/request/profile_req.dart';
import 'package:parkingappmobile/repository/impl/profile_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class ValidationItem {
  String value;
  String? error;
  ValidationItem(this.value, this.error);
}

class UserProfileProvider with ChangeNotifier {
  ValidationItem firstName = ValidationItem("", null);
  ValidationItem lastName = ValidationItem("", null);
  ValidationItem email = ValidationItem("", null);
  ValidationItem phone = ValidationItem("", null);

  bool clickButtonFlag = false;

  FocusNode nodeFirstName = FocusNode();
  FocusNode nodeLastName = FocusNode();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePhone = FocusNode();

  var firstNameTextEditingController = TextEditingController();
  var lastNameTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var phoneTextEditingController = TextEditingController();
  var dobTextEditingController = TextEditingController();

  void getProfile() async {
    final SecureStorage secureStorage = SecureStorage();
    String firstNameSto = await secureStorage.readSecureData('firstName');
    String lastNameSto = await secureStorage.readSecureData('lastName');
    String emailSto = await secureStorage.readSecureData('emailAddress');
    String phoneSto = await secureStorage.readSecureData('phoneNumber');
    String dobSto = await secureStorage.readSecureData('DOB');

    firstName.value = firstNameSto;
    lastName.value = lastNameSto;
    email.value = emailSto;
    phone.value = phoneSto;

    firstNameTextEditingController.text = firstNameSto;
    lastNameTextEditingController.text = lastNameSto;
    emailTextEditingController.text = emailSto;
    phoneTextEditingController.text = phoneSto;
    dobTextEditingController.text = dobSto;
  }

  TextEditingController get firstNameController =>
      firstNameTextEditingController;
  TextEditingController get lastNameController => lastNameTextEditingController;
  TextEditingController get emailController => emailTextEditingController;
  TextEditingController get phoneController => phoneTextEditingController;
  TextEditingController get dobController => dobTextEditingController;

  bool checkFirstName(String value) {
    firstName.value = value;
    bool flag = true;
    if (value.isEmpty) {
      firstName.error = "First name not empty";
      flag = false;
    } else {
      firstName.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkLastName(String value) {
    lastName.value = value;
    bool flag = true;
    if (value.isEmpty) {
      lastName.error = "Last name not empty";
      flag = false;
    } else {
      lastName.error = null;
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
    if (value.length != 9) {
      phone.error = "Phone number must have 9 characters excluding +84";
      flag = false;
    } else {
      phone.error = null;
    }
    notifyListeners();
    return flag;
  }

  void submit() {
    clickButtonFlag = true;
    bool isFirstName = checkFirstName(firstName.value);
    bool isLastName = checkLastName(lastName.value);
    bool isEmail = checkEmail(email.value);
    bool isPhone = checkPhone(phone.value);
    if (isFirstName && isLastName && isEmail && isPhone) {
      ProfileRepImpl()
          .putProfile(
        UrlApi.profilePath,
        ProfileReq(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dob: dobController.text,
          phoneNumber: '+84' + phoneController.text,
          email: emailController.text,
          address: firstNameController.text,
          avatar: firstNameController.text,
        ),
      )
          .then((value) async {
        showToastSuccess(value.result!);
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
    notifyListeners();
  }
}
