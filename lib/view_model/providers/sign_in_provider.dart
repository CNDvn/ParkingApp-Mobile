import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/exception/show_alert_dialog.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/login_gg_req.dart';
import 'package:parkingappmobile/model/request/sign_in_req.dart';
import 'package:parkingappmobile/repository/impl/auth_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/users_me_rep_impl.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkingappmobile/configs/exception/exception.dart';
import 'package:parkingappmobile/view/login/signin_page.dart';
import 'package:parkingappmobile/view_model/auth.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class SignInProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  ValidationItem _phone = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  bool isPasswordVariable = true;
  bool submitValid = false;

  final _phoneTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  ValidationItem get phone => _phone;
  ValidationItem get password => _password;

  TextEditingController get phoneController => _phoneTextEditController;
  TextEditingController get passwordController => _passwordTextEditController;

  String get textPhone => phoneController.text;
  String get textPassword => passwordController.text;

  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get passwordFocus => _passwordFocus;

  void clearPhoneController() {
    phoneController.clear();
    notifyListeners();
  }

  void clearPasswordController() {
    passwordController.clear();
    notifyListeners();
  }

  void changePasswordVariable() {
    isPasswordVariable = !isPasswordVariable;
    notifyListeners();
  }

  void checkPhone(String value) {
    if (value.isEmpty) {
      _phone = ValidationItem(value, "Phone is empty");
    } else if (value.length < 10) {
      _phone = ValidationItem(value, "Phone must 10 charactor");
    } else {
      _phone = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void checkPassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem(value, "Password is empty");
    } else if (value.length < 8) {
      _password = ValidationItem(value, "Password must 8 charactor");
    } else {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _phoneFocus;
    if (_phone.value != null && field.contains("phone")) {
      newFocus = _passwordFocus;
      FocusScope.of(context).requestFocus(newFocus);
      return;
    }
    if (_password.value != null && field.contains('password')) {
      FocusScope.of(context).unfocus();
      submitData(context);
    }
  }

  bool get isValid {
    if (_phone.value != null && _password.value != null) {
      return true;
    }
    return false;
  }

  void submitData(BuildContext context) {
    submitValid = _phone.error != null ||
        _password.error != null ||
        _phone.value == null ||
        password.value == null;

    if (submitValid) {
      checkPhone(_phone.value ?? "");
      checkPassword(_password.value ?? "");
      notifyListeners();
    } else if (!submitValid && isValid) {
      AuthRepImpl()
          .postSignIn(
              UrlApi.signinPath,
              SignInReq(
                  username: phone.value!,
                  password: password.value!,
                  role: "customer"))
          .then((value) async {
        await secureStorage.writeSecureData("token", value.result!.accessToken);
        await secureStorage.writeSecureData("customer", value.result!.refreshToken);
        clearPhoneController();
        clearPasswordController();
        UsersMeRepImpl()
            .getUsersMe(UrlApi.usersMePath, value.result!.accessToken);
        showToastSuccess(value.result!.message);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BottomTabBar();
        }));
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') return;
    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  final AuthBase auth = Auth();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User? user = await auth.signInWithGoogle();
      if (user != null) {
        await secureStorage.writeSecureData("emailAddress", user.email ?? "");
        await secureStorage.writeSecureData("lastName", user.displayName ?? "");
        await secureStorage.writeSecureData("phoneNumber", user.phoneNumber?.substring(3) ?? "");
        await secureStorage.writeSecureData("avatar", user.photoURL ?? "");
        String token = await user.getIdToken();
        AuthRepImpl()
            .postLoginGoogle("", LoginGgReq(token: token), context)
            .then((value) async {
        await  secureStorage.writeSecureData("token", value.result!.accessToken);
        await  secureStorage.writeSecureData("customer", value.result!.refreshToken);
          UsersMeRepImpl()
              .getUsersMe(UrlApi.usersMePath, value.result!.accessToken);
          showToastSuccess(value.result!.message);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const BottomTabBar();
          }));
        });
      }
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await auth.signOut();
      String accessToken = await secureStorage.readSecureData("token");
      AuthRepImpl().postSignOut("", accessToken);
      secureStorage.deleteAll();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const SignInPage()),
          ModalRoute.withName('/'));
    }
  }
}
