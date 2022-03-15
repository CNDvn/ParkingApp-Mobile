import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/change_password_rep.dart';
import 'package:parkingappmobile/repository/impl/auth_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/change_password_rep_impl.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class ValidationPassword {
  String value;
  String? error;
  ValidationPassword(this.value, this.error);
}

class EnterChangePasswordProvider with ChangeNotifier {
  bool isPasswordVariable = true;
  bool isNewPasswordVariable = true;

  ValidationPassword password = ValidationPassword("", null);
  ValidationPassword newPassword = ValidationPassword("", null);

  bool clickButtonFlag = false;
  FocusNode nodePassword = FocusNode();
  FocusNode nodeNewPassword = FocusNode();

  final _passwordTextEditController = TextEditingController();
  TextEditingController get passwordController => _passwordTextEditController;
  String get textPassword => passwordController.text;

  final _newPasswordTextEditController = TextEditingController();
  TextEditingController get newPasswordController =>
      _newPasswordTextEditController;
  String get textNewPassword => newPasswordController.text;

  void clearPasswordController() {
    passwordController.clear();
    notifyListeners();
  }

  void clearNewPasswordController() {
    newPasswordController.clear();
    notifyListeners();
  }

  void changePasswordVariable() {
    isPasswordVariable = !isPasswordVariable;
    notifyListeners();
  }

  void changeNewPasswordVariable() {
    isNewPasswordVariable = !isNewPasswordVariable;
    notifyListeners();
  }

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

  bool checkNewPassword(String value) {
    newPassword.value = value;
    bool flag = true;
    if (value.trim().isEmpty) {
      newPassword.error = "Confirm password is not empty";
      flag = false;
    } else if (value.length < 8) {
      newPassword.error = "New Password must 8 charactor ";
    } else {
      newPassword.error = null;
    }
    notifyListeners();
    return flag;
  }

  void submit(BuildContext context) async {
    clickButtonFlag = true;
    bool isPassword = checkPassword(password.value);
    bool isNewPassword = checkNewPassword(newPassword.value);
    final SecureStorage secureStorage = SecureStorage();
    final token = await secureStorage.readSecureData("token");
    if (isPassword && isNewPassword) {
      showDialogCustom(context);
      ChangePasswordRepImpl()
          .putChangePassword(
              UrlApi.changePasswordPath,
              ChangePasswordReq(
                  password: password.value, newPassword: newPassword.value),
              token)
          .then((value) async {
        showToastSuccess(value.result!);
        //--------------
        String accessToken = await secureStorage.readSecureData("token");
        AuthRepImpl().postSignOut(UrlApi.signOut, accessToken);
        secureStorage.deleteAll();
        //----------------
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignInPage()),
            (route) => false);
      }).then((value) => {});
    }
  }
}
