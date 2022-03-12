import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/card_car_rep_impl.dart';
import 'package:parkingappmobile/view/my_car/create_car.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class CarDetailProvider with ChangeNotifier {
  void detailCar(BuildContext context, String? id) {
    CardCarImpl()
        .getCarDetail(UrlApi.serverPath + "/cars/$id")
        .then((value) async {
      final SecureStorage secureStorage = SecureStorage();
      final token = await secureStorage.readSecureData("token");
      CarRepImpl().getTypeCars(UrlApi.typeCarsPath, token).then((data) async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateCar(
            car: value.result,
            isUpdate: true,
            typeCars: data.result,
          );
        }));
      });
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
