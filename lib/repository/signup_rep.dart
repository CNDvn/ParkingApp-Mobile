import 'package:parkingappmobile/model/request/sign_up_req.dart';
import 'package:parkingappmobile/model/response/sign_up_res.dart';

abstract class SignUpRepo {
  Future<SignUpRes> postSignUp(String url, SignUpReq payload);
}
