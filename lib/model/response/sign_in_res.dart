// To parse this JSON data, do
//
//     final signInRes = signInResFromJson(jsonString);

import 'dart:convert';

class SignInRes {
    SignInRes({
      this.result,
      this.statusCode,
    });

    Result? result;
    int? statusCode;

    factory SignInRes.fromJson(Map<String, dynamic> json) => SignInRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
    };

    static SignInRes signInResFromJson(String str) => SignInRes.fromJson(json.decode(str));

    String signInResToJson(SignInRes data) => json.encode(data.toJson());
}

class Result {
    Result({
      required this.accessToken,
      required this.refreshToken,
      required this.message,
    });

    String accessToken;
    String refreshToken;
    String message;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "message": message,
    };
}
