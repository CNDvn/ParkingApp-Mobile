// To parse this JSON data, do
//
//     final verifyOtpRes = verifyOtpResFromJson(jsonString);

import 'dart:convert';

class VerifyOtpRes {
  VerifyOtpRes({
    this.statusCode,
    this.result,
  });

  int? statusCode;
  String? result;

  factory VerifyOtpRes.fromJson(Map<String, dynamic> json) => VerifyOtpRes(
        statusCode: json["statusCode"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "result": result,
      };

  static VerifyOtpRes verifyOtpResFromJson(String str) =>
      VerifyOtpRes.fromJson(json.decode(str));

  String verifyOtpResToJson(VerifyOtpRes data) => json.encode(data.toJson());
}
