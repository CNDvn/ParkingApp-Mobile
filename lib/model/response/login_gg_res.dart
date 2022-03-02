// To parse this JSON data, do
//
//     final loginGgRes = loginGgResFromJson(jsonString);

import 'dart:convert';

class LoginGgRes {
  LoginGgRes({
    this.statusCode,
    this.message,
  });

  int? statusCode;
  String? message;

  factory LoginGgRes.fromJson(Map<String, dynamic> json) => LoginGgRes(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };

  static LoginGgRes loginGgResFromJson(String str) =>
      LoginGgRes.fromJson(json.decode(str));

  String loginGgResToJson(LoginGgRes data) => json.encode(data.toJson());
}
