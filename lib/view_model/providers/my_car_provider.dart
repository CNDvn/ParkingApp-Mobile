import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/base/base_validation.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/entity/car.dart';
import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/repository/impl/bookign_rep_impl.dart';
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

  // ignore: prefer_collection_literals
  Map<String, Car> listMyCar = Map<String, Car>();
  List<String> cars = [];
  String? firstCar;
  String key = "";
  String? keyFirst = "";
  List<String> myCarsBooked = [];
  String? firstCarBooked;
  String carBooked = "";
  // ignore: prefer_collection_literals
  Map<String, String> carBook = Map();
  getMyCar() async {
    String accessToken = await secureStorage.readSecureData("token");
    List<Car>? myCars = [];
    CarRepImpl().getMyCar(UrlApi.userCar, accessToken).then((value) {
      myCars = value.result;
      for (var item in myCars!) {
        // ignore: prefer_collection_literals
        Map<String, Car> tmp = Map<String, Car>();
        tmp[item.id!] = item;
        listMyCar.addAll(tmp);
        cars.add(item.nPlates!);
      }
      firstCar = cars[0];
      key = listMyCar[0]!.id!;      
    });
    notifyListeners();
  }

  getCarBooking() async {
    myCarsBooked.clear();
    carBooked = "";
    String accessToken = await secureStorage.readSecureData("token");
    List<Car>? myCars = [];
    CarRepImpl().getMyCar(UrlApi.userCar, accessToken).then((value) {
      myCars = value.result;
      for (var item in myCars!) {
        if (!item.status!.contains("active")) {
          myCarsBooked.add(item.nPlates!);
          // ignore: prefer_collection_literals
          Map<String, String> carBooktmp = Map();
          carBooktmp[item.id!] = item.nPlates!;
          carBook.addAll(carBooktmp);
        }
      }
      firstCarBooked = carBook[0];
    });
    notifyListeners();
  }

  getIdCar() {
    secureStorage.deleteSecureData("idCar");
    listMyCar.forEach((key, value) {
      if (firstCar!.contains(value.nPlates!)) {
        this.key = key;
        secureStorage.writeSecureData("idCar", this.key);
        carBooked = firstCar!;
      }
    });
    notifyListeners();
  }

  getIdCarBooked() {
    secureStorage.deleteSecureData("idCar");
    listMyCar.forEach((key, value) async {
      if (firstCarBooked!.contains(value.nPlates!)) {
        this.key = key;
        secureStorage.writeSecureData("idCar", this.key);
      }
    });
    notifyListeners();
  }

  String startTime ="";
  int countTime =0;
  String parkingName= "";
  int hoursBook = 0;
  int minutesBook = 0;
  int secondsBook = 0;
  DateTime? now;
  getBookingByIdCar() async {
    startTime ="";
    parkingName= "";
    String accessToken = await secureStorage.readSecureData("token");
    String url = "https://parking-app-project.herokuapp.com/api/v1/bookings/car/$key";
    BookingRepImpl().getBookingByIdCar(url, accessToken).then((value) {
      if (value.statusCode == 200){
        hoursBook = DateTime.now().hour - value.result!.startTime!.add(const Duration(hours: 7)).hour;
        minutesBook = DateTime.now().minute - value.result!.startTime!.add(const Duration(hours: 7)).minute;
        secondsBook = DateTime.now().second -  value.result!.startTime!.add(const Duration(hours: 7)).second;
        startTime = DateFormat('KK:mm:a').format(value.result!.startTime!.add(const Duration(hours: 7)));
        parkingName = value.result!.parking!.name!;
      }
    });
    notifyListeners();
  }

  getList() async {
    getMyCar();
    getCarBooking();
    notifyListeners();
  }
}
