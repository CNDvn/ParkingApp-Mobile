import 'package:parkingappmobile/model/request/resetPassword/reset_password_req.dart';
import 'package:parkingappmobile/model/response/resetPassword/reset_password_res.dart';

abstract class ResetPasswordRepo {
  Future<ResetPasswordRes> putResetPassword(String url, ResetPasswordReq req);
}