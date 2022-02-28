import 'package:parkingappmobile/model/request/resetPassword/otp_req.dart';
import 'package:parkingappmobile/model/response/resetPassword/otp_res.dart';

abstract class OtpRepo {
  Future<OtpRes> postOtp(String url, OtpReq req);
}