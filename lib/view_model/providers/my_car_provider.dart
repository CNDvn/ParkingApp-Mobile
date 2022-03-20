import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/entity/car.dart';
import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/repository/impl/bookign_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/image_rep_impl.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';

enum StatusCarEnum { active, booked, inParking }

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

  void clearAll() {
    clearBrandController();
    clearColorController();
    clearModelCodeController();
    clearNPlateController();
    image = null;
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
          mapProvider.reset();
          clearAll();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const BottomTabBar();
          }));
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
  // ignore: prefer_collection_literals
  Map<String, Car> listMyCarBooked = Map<String, Car>();
  // ignore: prefer_collection_literals
  Map<String, Car> listMyCarInParking = Map<String, Car>();
  // ignore: prefer_collection_literals
  Map<String, Car> listMyCarNotActive = Map<String, Car>();
  // List<String> cars = [];
  String? firstCar;
  String key = "";
  String? keyFirst = "";
  // List<String> myCarsBooked = [];
  // List<String> myCarsInParking = [];
  String? firstCarBooked;
  String carBooked = "";
  // ignore: prefer_collection_literals
  Map<String, String> carBook = Map();
  //--------------------
  String checkinTime = "";
  String startTime = "";
  int countTime = 0;
  String parkingName = "";
  DateTime now = DateTime.now();
  String price="";
  final format = NumberFormat("#,##0,000");
  // resetMyCar() {
  //   firstCarBooked="";
  //   keyFirst="";
  // }
  getMyCar() async {
    // if (listMyCarNotActive.isNotEmpty) {
    //   listMyCarBooked.clear();
    //   listMyCarInParking.clear();
    //   listMyCarNotActive.clear();
    // }
    // listMyCarBooked.clear();
    // listMyCarInParking.clear();
    // listMyCarNotActive.clear();
    String accessToken = await secureStorage.readSecureData("token");
    List<Car>? myCars = [];
    CarRepImpl().getMyCar(UrlApi.userCar, accessToken).then((value) {
      myCars = value.result;
      for (var item in myCars!) {
        // ignore: prefer_collection_literals
        Map<String, Car> tmp = Map<String, Car>();
        tmp[item.nPlates] = item;
        if (item.status.contains(StatusCarEnum.booked.name)) {
          listMyCarBooked.addAll(tmp);
          listMyCarNotActive.addAll(tmp);
        }
        if (item.status.contains(StatusCarEnum.inParking.name)) {
          listMyCarInParking.addAll(tmp);
          listMyCarNotActive.addAll(tmp);
        }
        listMyCar.addAll(tmp);
      }
      firstCar = listMyCar.keys.first;
      key = listMyCar[0]!.id;
    });
    notifyListeners();
  }

  getIdCar() {
    secureStorage.deleteSecureData("idCar");
    listMyCar.forEach((key, value) {
      if (firstCar!.contains(key)) {
        this.key = value.id;
        secureStorage.writeSecureData("idCar", value.id);
        return;
      }
    });
    notifyListeners();
  }

  getIdCarBooked() {
    secureStorage.deleteSecureData("idCar");
    secureStorage.deleteSecureData("nameCar");
    listMyCarNotActive.forEach((key, value) async {
      if (firstCarBooked!.contains(key)) {
        this.key = value.id;
        secureStorage.writeSecureData("idCar", value.id);
        secureStorage.writeSecureData("nameCar", firstCarBooked!);
        carBooked = firstCarBooked!;
        return;
      }
    });
    notifyListeners();
  }

  getInParkingByIdCar() async {
    checkinTime = "";
    startTime = "";
    countTime = 0;
    now = DateTime.now();
    String accessToken = await secureStorage.readSecureData("token");
    String url = "${UrlApi.serverPath}/bookings/car/$key";
    if (!listMyCarInParking.keys.contains(firstCarBooked)){
      return;
    }
    BookingRepImpl().getBookingByIdCar1(url, accessToken).then((value) {
      if (value.statusCode == 200) {
        now = DateTime.now().subtract(Duration(
            hours:
                value.result!.checkinTime!.add(const Duration(hours: 7)).hour,
            minutes:
                value.result!.checkinTime!.add(const Duration(hours: 7)).minute,
            seconds: value.result!.checkinTime!
                .add(const Duration(hours: 7))
                .second));
        checkinTime = DateFormat('KK:mm:a')
            .format(value.result!.checkinTime!.add(const Duration(hours: 7)));
        startTime = DateFormat('KK:mm:a')
            .format(value.result!.startTime!.add(const Duration(hours: 7)));
        secureStorage.writeSecureData("checkinTime", checkinTime);
        secureStorage.writeSecureData("startTime", startTime);
        parkingName = value.result!.parking!.name!;
        price = format.format(double.parse(value.result!.price!
                              .substring(0, value.result!.price!.length - 4)))
                          .toString() +
                      " VND/Hour";
      }
    });
    notifyListeners();
  }

  getInBookedByIdCar() async {
    startTime = "";
    String accessToken = await secureStorage.readSecureData("token");
    String url = "${UrlApi.serverPath}/bookings/car/$key";    
    BookingRepImpl().getBookingByIdCar(url, accessToken).then((value) {
      if (value.statusCode == 200) {
        startTime = DateFormat('KK:mm:a')
            .format(value.result!.startTime!.add(const Duration(hours: 7)));
        secureStorage.writeSecureData("startTime", startTime);
        parkingName = value.result!.parking!.name!;
      }
    });
    notifyListeners();
  }

  checkFirstCarBooked() {
    if (listMyCarInParking.containsKey(firstCarBooked)) {
      getInParkingByIdCar();
      return;
    }
    if (listMyCarBooked.containsKey(firstCarBooked)) {
      checkinTime ="";
      getInBookedByIdCar();
      return;
    }
    notifyListeners();
  }

  getList() async {
    getMyCar();
    // getCarBooking();
    notifyListeners();
  }
}
