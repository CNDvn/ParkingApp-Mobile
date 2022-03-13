import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/model/request/upload_car_req.dart';
import 'package:parkingappmobile/model/response/card_car_res.dart';
import 'package:parkingappmobile/model/response/create_car_res.dart';
import 'package:parkingappmobile/model/response/mycar_res.dart';
import 'package:parkingappmobile/model/response/type_cars_res.dart';
import 'package:parkingappmobile/model/response/upload_car_res.dart';
import 'package:parkingappmobile/repository/car_rep.dart';

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
  Future<CardCarRes> getCardCar(String url, String token) async {
    var result = CardCarRes();
    try {
      Response response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
      result = CardCarRes.cardCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<UploadCarRes> putCardCar(
      String url, UploadCarReq req, String token) async {
    var result = UploadCarRes();
    try {
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
      result = UploadCarRes.uploadCarResFromJson(jsonEncode(response.data));
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
