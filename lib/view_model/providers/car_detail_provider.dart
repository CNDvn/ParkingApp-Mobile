import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/upload_car_req.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/image_rep_impl.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';

class CarDetailProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String? id;
  File? image;
  String? imageID;
  String? imageSto;
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

  void clearAll() {
    clearBrandController();
    clearColorController();
    clearModelCodeController();
    clearNPlateController();
    image = null;
  }

  void addData(
      String idData,
      String imageIdData,
      String imageStoData,
      String brandData,
      String colorData,
      String modelCodeData,
      String nPlatesData,
      String dropdownValueData) {
    id = idData;
    imageID = imageIdData;
    imageSto = imageStoData;
    brandController.text = brandData;
    colorController.text = colorData;
    modelCodeController.text = modelCodeData;
    nPlateController.text = nPlatesData;
    dropdownValue = dropdownValueData;
    _brand = ValidationItem(brandData, null);
    _color = ValidationItem(colorData, null);
    _modelCode = ValidationItem(modelCodeData, null);
    _nPlate = ValidationItem(nPlatesData, null);
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
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: false);
    submitValid = _brand.error != null ||
        _color.error != null ||
        _modelCode.error != null ||
        _nPlate.error != null;
    String token = await secureStorage.readSecureData('token');
    if (submitValid) {
      checkValidation(_brand.value ?? "", "brand");
      checkValidation(_color.value ?? "", "color");
      checkValidation(_modelCode.value ?? "", "modelCode");
      checkValidation(_nPlate.value ?? "", "nPlate");
    } else if (image != null) {
      await ImageRepImpl()
          .postImage(UrlApi.imagesPath, image!, token)
          .then((value) async {
        final imageID = await secureStorage.readSecureData("imageID");
        await CarRepImpl()
            .putCardCar(
                UrlApi.carsPath + "/$id",
                UploadCarReq(
                    nPlates: _nPlate.value!.toUpperCase(),
                    brand: _brand.value!.toUpperCase(),
                    color: _color.value!.toUpperCase(),
                    modelCode: _modelCode.value!.toUpperCase(),
                    typeCarId: dropdownValue!,
                    images: [imageID!]),
                token)
            .then((value) async {
          showToastSuccess("Success");
          mapProvider.reset();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const BottomTabBar();
          }));
          await secureStorage.deleteSecureData("imageID");
        }).onError((error, stackTrace) {
          log(error.toString());
        });
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    } else {
      await CarRepImpl()
          .putCardCar(
              UrlApi.carsPath + "/$id",
              UploadCarReq(
                  nPlates: _nPlate.value!.toUpperCase(),
                  brand: _brand.value!.toUpperCase(),
                  color: _color.value!.toUpperCase(),
                  modelCode: _modelCode.value!.toUpperCase(),
                  typeCarId: dropdownValue!,
                  images: [imageID!]),
              token)
          .then((value) async {
        showToastSuccess("Success");
        mapProvider.reset();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BottomTabBar();
        }));
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }
}
