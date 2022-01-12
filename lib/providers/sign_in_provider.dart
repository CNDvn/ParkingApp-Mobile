import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class SignInProvider with ChangeNotifier {
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
    // String p = r'^(?:[+0]9)?[0-9]{10}$';
    // RegExp regExp = RegExp(p);
    print("VVVVVVVVVVVVVVVVVVV"+ _phone.value.toString()+ " VS "+ _phone.error.toString());
    print(submitValid);
    print(value.isEmpty);
    print(value.length < 10);
    print(submitValid && value.length < 10);
    if (submitValid && value.isEmpty) {
      _phone = ValidationItem(null, "Phone is empty");
    } else if (submitValid &&/*!regExp.hasMatch(value)*/value.length < 10) {
      _phone = ValidationItem(null, "Phone is invalid Pattern");      
    }else {
      _phone = ValidationItem(value, null);      
    }
    notifyListeners();
  }

  void checkPassword(String value) {
    print("YYYYYYYYYYYYYYY");
    if (submitValid && value.isEmpty) {
      _password = ValidationItem(null, "Password is empty");
    } else if (submitValid && value.length < 8) {
      _password = ValidationItem(null, "Password must 8 charactor"); 
    }else {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _phoneFocus;
    if (_phone.value != null && field.contains('phone')) {
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
    if (_phone.value !=null && _password.value !=null) {
      return true;
    }
    return false;
  }

  void submitData(BuildContext context) {   
    print("***********"+submitValid.toString()); 
    submitValid = _phone.value != null &&
        _phone.error == null &&
        _password.value != null &&
        _password.error == null;
    print("==========="+submitValid.toString());
    if (!submitValid) {
      submitValid = true;
      checkPhone(_phone.value ?? "");
      checkPassword(_password.value ?? "");
      notifyListeners();
    } else if (submitValid && isValid){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const RootPage()),
          (route) => false);
    }
  }
}
