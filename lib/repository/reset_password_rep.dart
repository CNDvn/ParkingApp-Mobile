import 'package:parkingappmobile/model/request/reset_password_req.dart';
import 'package:parkingappmobile/model/response/reset_password_res.dart';

abstract class ResetPasswordRepo {
  Future<ResetPasswordRes> putResetPassword(String url, ResetPasswordReq req);
}