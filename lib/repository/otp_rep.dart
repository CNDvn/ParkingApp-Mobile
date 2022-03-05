import 'package:parkingappmobile/model/request/otp_req.dart';
import 'package:parkingappmobile/model/response/otp_res.dart';

abstract class OtpRepo {
  Future<OtpRes> postOtp(String url, OtpReq req);
}