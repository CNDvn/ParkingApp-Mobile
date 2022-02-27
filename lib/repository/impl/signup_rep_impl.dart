import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/sign_up_req.dart';
import 'package:parkingappmobile/model/response/sign_up_res.dart';
import 'package:parkingappmobile/repository/signup_rep.dart';

class SignUpImpl implements SignUpRepo {
  @override
  Future<SignUpRes> postSignUp(String url, SignUpReq payload) async {
    var result = SignUpRes();
    try {
      Response response = await Dio().post(url, data: payload.toJson());
      result = SignUpRes.signUpResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
