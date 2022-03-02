import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/request/login_gg_req.dart';
import 'package:parkingappmobile/model/request/sign_in_req.dart';
import 'package:parkingappmobile/model/response/sign_in_res.dart';

abstract class AuthRepo {
  Future<SignInRes> postSignIn(String url, SignInReq req);
  Future<SignInRes> postLoginGoogle(String url, LoginGgReq req, BuildContext context);
}