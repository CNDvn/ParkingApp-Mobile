import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/sign_in_res.dart';
import 'package:parkingappmobile/model/request/sign_in_req.dart';
import 'package:parkingappmobile/repository/auth_rep.dart';

class AuthRepImpl implements AuthRepo {
  @override
  Future<SignInRes> postSignIn(String url, SignInReq req) async {
    var result = SignInRes();
    try {
      Response response = await Dio().post(url, data: req.toJson());
      result = SignInRes.signInResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result; 
  }
}