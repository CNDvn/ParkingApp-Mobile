import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/resetPassword/otp_res.dart';
import 'package:parkingappmobile/model/request/resetPassword/otp_req.dart';
import 'package:parkingappmobile/repository/otp_rep.dart';

class OtpRepImpl implements OtpRepo {
  @override
  Future<OtpRes> postOtp(String url, OtpReq req) async {
    var result = OtpRes();
    try {
      Response response = await Dio().post(url, data: req.toJson());
      result = OtpRes.otpResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

}