import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/request/otp_req.dart';
import 'package:parkingappmobile/model/request/reset_password_req.dart';
import 'package:parkingappmobile/repository/impl/otp_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/reset_password_rep_impl.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view/resetPassword/enter_verification_code.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class ResetPasswordProvider with ChangeNotifier {
  ValidationItem _phone = ValidationItem(null, null);
  ValidationItem _otp = ValidationItem(null, null);

  bool submitValid = false;
  bool submitValidOtp = false;

  final _phoneTextEditController = TextEditingController();
  final _phoneFocus = FocusNode();

  final _otpTextEditController = TextEditingController();
  final _otpFocus = FocusNode();

  ValidationItem get phone => _phone;
  ValidationItem get otp => _otp;

  TextEditingController get phoneController => _phoneTextEditController;
  TextEditingController get otpController => _otpTextEditController;

  String get textPhone => phoneController.text;
  String get textOtp => otpController.text;

  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get otpFocus => _otpFocus;

  void clearPhoneController() {
    phoneController.clear();
    notifyListeners();
  }

  void clearOtpController() {
    otpController.clear();
    notifyListeners();
  }

  void checkPhone(String value) {
    if (value.isEmpty) {
      _phone = ValidationItem(value, "Phone is empty");
    } else if (value.length < 10) {
      _phone = ValidationItem(value, "Phone must 10 character");
    } else {
      _phone = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void checkOtp(String value) {
    if (value.isEmpty) {
      _otp = ValidationItem(value, "Otp is empty");
    } else if (value.length < 4) {
      _phone = ValidationItem(value, "Phone must 4 character");
    } else {
      _phone = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeFocus(BuildContext context, String field) {
    if (_phone.value != null && field.contains("phone")) {
      FocusScope.of(context).unfocus();
      submitUsername(context);
    }
  }

  void changeOtpFocus(BuildContext context, String field) {
    if (_otp.value != null && field.contains("otp")) {
      FocusScope.of(context).unfocus();
      submitOtp(context, "username", 1);
    }
  }

  bool get isValid {
    if (_phone.value != null) {
      return true;
    }
    return false;
  }

  bool get isValidOtp {
    if (_otp.value != null) {
      return true;
    }
    return false;
  }

  void submitUsername(BuildContext context) {
    submitValid = _phone.error != null || _phone.value == null;

    if (submitValid) {
      checkPhone(_phone.value ?? "");
      notifyListeners();
    } else if (!submitValid && isValid) {
      OtpRepImpl()
          .postOtp(UrlApi.otpPath, OtpReq(username: phone.value!))
          .then((value) async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EnterVerificationCodeReset(username: phone.value!)),
        );
      }).catchError((error, stackTrace) {
        log(error.toString());
      });
    }
  }

  void submitOtp(BuildContext context, String username, int otp) {
    if (otp == 0) {
      checkOtp(otp.toString());
      notifyListeners();
    } else {
      ResetPasswordRepImpl()
          .putResetPassword(UrlApi.resetpasswordPath,
              ResetPasswordReq(otp: otp, username: username))
          .then((value) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      }).catchError((error, stackTrace) {
        log(error.toString());
      });
    }
  }
}
