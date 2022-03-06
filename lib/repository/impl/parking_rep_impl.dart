import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/parking_detail_res.dart';

import 'package:parkingappmobile/model/response/parking_res.dart';
import 'package:parkingappmobile/repository/parking_rep.dart';

class ParkingImpl implements ParkingRepo {
  @override
  Future<ParkingsRes> getParkings(String url) async {
    var result = ParkingsRes();
    try {
      Response response = await Dio().get(url);
      result = ParkingsRes.parkingsResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<ParkingDetailRes> getParkingDetail(String url) async {
    var result = ParkingDetailRes();
    try {
      Response response = await Dio().get(url);
      result =
          ParkingDetailRes.parkingDetailResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
