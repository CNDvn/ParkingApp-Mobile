
import 'package:parkingappmobile/model/request/verify_otp_req.dart';
import 'package:parkingappmobile/model/response/verify_otp_res.dart';

abstract class VerifyRepo {
  Future<VerifyOtpRes> postVerifyOTPSignUp(String url, VerifyOtpSignUpReq payload);
}
