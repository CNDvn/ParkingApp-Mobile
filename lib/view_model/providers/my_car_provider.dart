import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/base/base_validation.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/image_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class MyCarProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();

  File? image;
  ValidationItem _brand = ValidationItem("", "");
  ValidationItem _color = ValidationItem("", "");
  ValidationItem _modelCode = ValidationItem("", "");
  ValidationItem _nPlate = ValidationItem("", "");
  String? dropdownValue;

  ValidationItem get brand => _brand;
  ValidationItem get color => _color;
  ValidationItem get modelCode => _modelCode;
  ValidationItem get nPlate => _nPlate;

  final _brandTextEditController = TextEditingController();
  final _colorTextEditController = TextEditingController();
  final _modelCodeTextEditController = TextEditingController();
  final _nPlateTextEditController = TextEditingController();

  TextEditingController get brandController => _brandTextEditController;
  TextEditingController get colorController => _colorTextEditController;
  TextEditingController get modelCodeController => _modelCodeTextEditController;
  TextEditingController get nPlateController => _nPlateTextEditController;

  

  String get textBrand => brandController.text;
  String get textColor => colorController.text;
  String get textModelCode => modelCodeController.text;
  String get textNPlate => nPlateController.text;

  final _brandFocus = FocusNode();
  final _colorFocus = FocusNode();
  final _modelCodeFocus = FocusNode();
  final _nPlateFocus = FocusNode();

  FocusNode get brandFocus => _brandFocus;
  FocusNode get colorFocus => _colorFocus;
  FocusNode get modelCodeFocus => _modelCodeFocus;
  FocusNode get nPlateFocus => _nPlateFocus;

  bool submitValid = false;

  void clearBrandController() {
    brandController.clear();
    _brand = ValidationItem("", "");
    notifyListeners();
  }

  void clearColorController() {
    colorController.clear();
    _color = ValidationItem("", "");
    notifyListeners();
  }

  void clearModelCodeController() {
    modelCodeController.clear();
    _modelCode = ValidationItem("", "");
    notifyListeners();
  }

  void clearNPlateController() {
    nPlateController.clear();
    _nPlate = ValidationItem("", "");
    notifyListeners();
  }

  TextEditingController setBrandController(String value) {
    brandController.value = TextEditingValue(text: value);
    return brandController;
  }

  TextEditingController setColorController(String value) {
    colorController.value = TextEditingValue(text: value);
    return colorController;
  }

  TextEditingController setPlateController(String value) {
    nPlateController.value = TextEditingValue(text: value);
    return nPlateController;
  }

  TextEditingController setModelCodeController(String value) {
    modelCodeController.value = TextEditingValue(text: value);
    return modelCodeController;
  }

  void checkValidation(String value, String key) {
    switch (key) {
      case "brand":
        if (value.isEmpty) {
          _brand = ValidationItem(value, "Brand is empty");
        } else {
          _brand = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "color":
        if (value.isEmpty) {
          _color = ValidationItem(value, "Color is empty");
        } else {
          _color = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "modelCode":
        if (value.isEmpty) {
          _modelCode = ValidationItem(value, "Model code is empty");
        } else {
          _modelCode = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "nPlate":
        if (value.isEmpty) {
          _nPlate = ValidationItem(value, "N°Plate is empty");
        } else {
          _nPlate = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      default:
    }
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _brandFocus;
    if (_brand.value != null && field.contains("brand")) {
      newFocus = _colorFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_color.value != null && field.contains("color")) {
      newFocus = _modelCodeFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_modelCode.value != null && field.contains("modelCode")) {
      newFocus = _nPlateFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_nPlate.value != null && field.contains("nPlate")) {
      FocusScope.of(context).unfocus();
      submitData(context);
    }
  }

  void submitData(BuildContext context) async {
    submitValid = _brand.error != null ||
        _color.error != null ||
        _modelCode.error != null ||
        _nPlate.error != null;

    if (submitValid) {
      checkValidation(_brand.value ?? "", "brand");
      checkValidation(_color.value ?? "", "color");
      checkValidation(_modelCode.value ?? "", "modelCode");
      checkValidation(_nPlate.value ?? "", "nPlate");
    } else if (image == null) {
      showToastFail("The image has not been updated yet");
    } else {
      final token = await secureStorage.readSecureData("token");
      ImageRepImpl()
          .postImage(UrlApi.imagesPath, image!, token)
          .then((value) async {
        final imageID = await secureStorage.readSecureData("imageID");
        List<String> images = [imageID];
        final data = CreateCarReq(
            nPlates: _nPlate.value!.toUpperCase(),
            brand: _brand.value!.toUpperCase(),
            color: _color.value!.toUpperCase(),
            modelCode: _modelCode.value!.toUpperCase(),
            typeCarId: dropdownValue!,
            images: images);
        CarRepImpl().postCar(UrlApi.carsPath, data, token).then((value) async {
          showToastSuccess("Create success");
          clearBrandController();
          clearColorController();
          clearModelCodeController();
          clearNPlateController();
          image = null;
        }).onError((error, stackTrace) {
          log(error.toString());
        });
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }
}
