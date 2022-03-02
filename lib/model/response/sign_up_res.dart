import 'dart:convert';

class SignUpRes {
  SignUpRes({
    this.result,
    this.statusCode,
  });

  String? result;
  int? statusCode;

  factory SignUpRes.fromJson(Map<String, dynamic> json) => SignUpRes(
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
      };

  static SignUpRes signUpResFromJson(String str) =>
      SignUpRes.fromJson(json.decode(str));

  String signUpResToJson(SignUpRes data) => json.encode(data.toJson());
}
