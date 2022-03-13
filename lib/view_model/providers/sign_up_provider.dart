import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/base/base_validation.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/sign_up_req.dart';
import 'package:parkingappmobile/repository/impl/signup_rep_impl.dart';
import 'package:parkingappmobile/view/sign_up/enter_verification_code.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class SignUpProvider with ChangeNotifier {  
  final SecureStorage secureStorage = SecureStorage();

  ValidationItem _phone = ValidationItem("", "");
  ValidationItem _password = ValidationItem("", "");
  ValidationItem _firstName = ValidationItem("", "");
  ValidationItem _lastName = ValidationItem("", "");
  ValidationItem _email = ValidationItem("", "");
  ValidationItem _address = ValidationItem("", "");

  var phoneTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();
  final _firstNameTextEditController = TextEditingController();
  final _lastNameTextEditController = TextEditingController();
  final _emailTextEditController = TextEditingController();
  final _addressTextEditController = TextEditingController();
  final _dobEditController = TextEditingController();

  TextEditingController get phoneController => phoneTextEditController;
  TextEditingController get passwordController => _passwordTextEditController;
  TextEditingController get firstNameController => _firstNameTextEditController;
  TextEditingController get lastNameController => _lastNameTextEditController;
  TextEditingController get emailController => _emailTextEditController;
  TextEditingController get addressController => _addressTextEditController;
  TextEditingController get dobController => _dobEditController;

  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();

  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get passwordFocus => _passwordFocus;
  FocusNode get firstNameFocus => _firstNameFocus;
  FocusNode get lastNameFocus => _lastNameFocus;
  FocusNode get emailFocus => _emailFocus;
  FocusNode get addressFocus => _addressFocus;

  bool submitValid = false;
  bool isPasswordVariable = true;

  //phone
  ValidationItem get phone => _phone;
  ValidationItem get password => _password;
  ValidationItem get firstName => _firstName;
  ValidationItem get lastName => _lastName;
  ValidationItem get email => _email;
  ValidationItem get address => _address;

  String get textPhone => phoneController.text;
  String get textPassword => passwordController.text;
  String get textFirstName => firstNameController.text;
  String get textLastName => lastNameController.text;
  String get textEmail => emailController.text;
  String get textAddress => addressController.text;

  void signUpGoogle() async {
    String emailSto = await secureStorage.readSecureData('emailAddress');
    String lastNameSto = await secureStorage.readSecureData('lastName');
    String phoneSto = await secureStorage.readSecureData('phoneNumber');

    email.value = emailSto;
    lastName.value = lastNameSto;
    phone.value = phoneSto;

    lastNameController.text = lastNameSto;
    emailController.text = emailSto;
    phoneTextEditController.text = phoneSto;
    notifyListeners();
  }

  void clearPhoneController() {
    phoneController.clear();
    notifyListeners();
  }

  void clearPasswordController() {
    passwordController.clear();
    notifyListeners();
  }

  void clearFirstNameController() {
    firstNameController.clear();
    notifyListeners();
  }

  void clearLastNameController() {
    lastNameController.clear();
    notifyListeners();
  }

  void clearEmailController() {
    emailController.clear();
    notifyListeners();
  }

  void clearAddressController() {
    addressController.clear();
    notifyListeners();
  }

  void changePasswordVariable() {
    isPasswordVariable = !isPasswordVariable;
    notifyListeners();
  }

  // validation check phone

  void checkValidation(String value, String key) {
    switch (key) {
      case "phone":
        if (value.isEmpty) {
          _phone = ValidationItem(value, "Phone is empty");
        } else if (value.length < 10) {
          _phone = ValidationItem(value, "Phone must 10 character ");
        } else {
          _phone = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "password":
        if (value.isEmpty) {
          _password = ValidationItem(value, "Password is empty");
        } else if (value.length < 8) {
          _password = ValidationItem(value, "Password must 8 character");
        } else {
          _password = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "firstName":
        if (value.isEmpty) {
          _firstName = ValidationItem(value, "firstName is empty");
        } else {
          _firstName = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "lastName":
        if (value.isEmpty) {
          _lastName = ValidationItem(value, "lastName is empty");
        } else {
          _lastName = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "email":
        if (value.isEmpty) {
          _email = ValidationItem(value, "email is empty");
        } else if (!RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$')
            .hasMatch(value)) {
          _email = ValidationItem(value, "email invalid ");
        } else {
          _email = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "address":
        if (value.isEmpty) {
          _address = ValidationItem(value, "address is empty");
        } else {
          _address = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      default:
    }
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _phoneFocus;
    if (_phone.value != null && field.contains("phone")) {
      newFocus = _passwordFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_password.value != null && field.contains('password')) {
      newFocus = _firstNameFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_firstName.value != null && field.contains("firstName")) {
      newFocus = _lastNameFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_lastName.value != null && field.contains("lastName")) {
      newFocus = _emailFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_email.value != null && field.contains("email")) {
      newFocus = _addressFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_address.value != null && field.contains("address")) {
      FocusScope.of(context).unfocus();
      submitData(context);
    }
  }

  void submitData(BuildContext context) {
    DateTime _date = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    submitValid = _phone.error != null ||
        _password.error != null ||
        _firstName.error != null ||
        _lastName.error != null ||
        _address.error != null;
    // check lần đầu
    if (submitValid) {
      checkValidation(_phone.value ?? "", "phone");
      checkValidation(_password.value ?? "", "password");
      checkValidation(_firstName.value ?? "", "firstName");
      checkValidation(_lastName.value ?? "", "lastName");
      checkValidation(_email.value ?? "", "email");
      checkValidation(_address.value ?? "", "address");
    } else {
      final data = SignUpReq(
          firstName: _firstName.value!,
          lastName: _lastName.value!,
          dob: _dobEditController.text.isEmpty
              ? dateFormat.format(_date)
              : _dobEditController.text,
          username: _phone.value!,
          password: _password.value!,
          phoneNumber: "+84" + _phone.value!.substring(1),
          email: _email.value!,
          address: _address.value!,
          avatar: "abc");
      showDialogCustom(context);
      SignUpImpl().postSignUp(UrlApi.signupPath, data).then((value) => {
            showToastSuccess(value.result!),
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EnterVerificationCode()),
            )
          }).onError((error, stackTrace) => {
            Navigator.pushReplacementNamed(context, "/SignUpPage")
          });
    }
  }
}
