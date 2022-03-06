// To parse this JSON data, do
//
//     final signOutRes = signOutResFromJson(jsonString);

import 'dart:convert';

class SignOutRes {
    SignOutRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory SignOutRes.fromJson(Map<String, dynamic> json) => SignOutRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };
    
static SignOutRes signOutResFromJson(String str) => SignOutRes.fromJson(json.decode(str));

String signOutResToJson(SignOutRes data) => json.encode(data.toJson());
}
