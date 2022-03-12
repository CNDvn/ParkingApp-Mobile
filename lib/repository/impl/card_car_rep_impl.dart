import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/car_detail_res.dart';
import 'package:parkingappmobile/model/response/card_car_res.dart';
import 'package:parkingappmobile/repository/card_car_rep.dart';

class CardCarImpl implements CardCarRepo {
  @override
  Future<CardCarRes> getCardCar(String url, String token) async {
    var result = CardCarRes();
    try {
      Response response = await Dio().get(url, options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token'
          }));
      result = CardCarRes.cardCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<CarDetailRes> getCarDetail(String url) async {
    var result = CarDetailRes();
    try {
      Response response = await Dio().get(url);
      result = CarDetailRes.carDetailResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

}