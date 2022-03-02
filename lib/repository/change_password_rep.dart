import 'package:parkingappmobile/model/request/change_password_rep.dart';
import 'package:parkingappmobile/model/response/change_password_res.dart';

abstract class ChangePasswordRepo {
  Future<ChangePasswordRes> putChangePassword(String url, ChangePasswordReq req, String token);
}