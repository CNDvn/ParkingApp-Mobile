import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/model/response/create_car_res.dart';
import 'package:parkingappmobile/model/response/mycar_res.dart';
import 'package:parkingappmobile/model/response/type_cars_res.dart';
import 'package:parkingappmobile/repository/car_rep.dart';
import 'package:parkingappmobile/view/my_car/my_car.dart';

class CarRepImpl implements CarRepo {
  @override
  Future<TypeCarsRes> getTypeCars(String url, String accessToken) async {
    var result = TypeCarsRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = TypeCarsRes.typeCarsResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<CreateCarRes> postCar(
      String url, CreateCarReq req, String accessToken) async {
    var result = CreateCarRes();
    try {
      Response response = await Dio().post(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = CreateCarRes.createCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<MyCarRes> getMyCar(String url, String accessToken) async {
    var result = MyCarRes();
    try {
      Response response = await Dio().get(url, options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = MyCarRes.myCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
