import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/login_gg_res.dart';
import 'package:parkingappmobile/model/request/login_gg_req.dart';
import 'package:parkingappmobile/model/response/sign_in_res.dart';
import 'package:parkingappmobile/model/request/sign_in_req.dart';
import 'package:parkingappmobile/repository/auth_rep.dart';
import 'package:parkingappmobile/view/sign_up/sign_up_page.dart';
import 'package:parkingappmobile/view_model/providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

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
  
  @override
  Future<SignInRes> postLoginGoogle(
      String url, LoginGgReq req, BuildContext context) async {
    var result = SignInRes();
    url = "https://parking-app-project.herokuapp.com/api/v1/auths/loginGoogle";
    try {
      Response response = await Dio().post(url, data: req.toJson());
      result = SignInRes.signInResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      if (e.response?.data["statusCode"] == 302) {
        SignUpProvider signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
        signUpProvider.signUpGoogle();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SignUpPage();
        }));
      }
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
