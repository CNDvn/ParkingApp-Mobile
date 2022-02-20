import 'package:parkingappmobile/model/request/sign_in_req.dart';
import 'package:parkingappmobile/model/response/sign_in_res.dart';

abstract class AuthRepo {
  Future<SignInRes> postSignIn(String url, SignInReq req);
}