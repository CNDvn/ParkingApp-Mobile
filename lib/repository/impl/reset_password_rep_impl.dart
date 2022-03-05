import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/reset_password_req.dart';
import 'package:parkingappmobile/model/response/reset_password_res.dart';
import 'package:parkingappmobile/repository/reset_password_rep.dart';

class ResetPasswordRepImpl implements ResetPasswordRepo {
  @override
  Future<ResetPasswordRes> putResetPassword(String url, ResetPasswordReq req) async {
    var result = ResetPasswordRes();
    try {
      Response response = await Dio().put(url, data: req.toJson());
      result = ResetPasswordRes.resetPasswordResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
      return Future.error("Not found username.!");
    }
    return result;
  }

}