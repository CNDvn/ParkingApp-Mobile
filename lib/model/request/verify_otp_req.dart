import 'dart:convert';

VerifyOtpSignUpReq verifyOtpSignUpReqFromJson(String str) =>
    VerifyOtpSignUpReq.fromJson(json.decode(str));

String verifyOtpSignUpReqToJson(VerifyOtpSignUpReq data) =>
    json.encode(data.toJson());

class VerifyOtpSignUpReq {
  VerifyOtpSignUpReq({
    required this.otp,
  });

  int otp;

  factory VerifyOtpSignUpReq.fromJson(Map<String, dynamic> json) =>
      VerifyOtpSignUpReq(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
