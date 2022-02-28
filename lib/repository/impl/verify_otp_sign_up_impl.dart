import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/verify_otp_req.dart';
import 'package:parkingappmobile/model/response/verify_otp_res.dart';
import 'package:parkingappmobile/repository/verify_otp_sign_up.dart';

class VerifyOTPRepImpl implements VerifyRepo {
  @override
  Future<VerifyOtpRes> postVerifyOTPSignUp(
      String url, VerifyOtpSignUpReq payload) async {
    var result = VerifyOtpRes();
    try {
      Response response = await Dio().post(url, data: payload.toJson());
      result = VerifyOtpRes.verifyOtpResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
