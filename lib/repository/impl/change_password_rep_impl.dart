import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/change_password_res.dart';
import 'package:parkingappmobile/model/request/change_password_rep.dart';
import 'package:parkingappmobile/repository/change_password_rep.dart';

class ChangePasswordRepImpl implements ChangePasswordRepo {
  @override
  Future<ChangePasswordRes> putChangePassword(
      String url, ChangePasswordReq req, String token) async {
    var result = ChangePasswordRes();
    try {
      Dio dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.put(url, data: req.toJson());

      result = ChangePasswordRes.changePasswordResFromJson(
          jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
