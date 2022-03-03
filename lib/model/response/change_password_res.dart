// To parse this JSON data, do
//
//     final changePasswordRes = changePasswordResFromJson(jsonString);

import 'dart:convert';



class ChangePasswordRes {
    ChangePasswordRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory ChangePasswordRes.fromJson(Map<String, dynamic> json) => ChangePasswordRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };

    static ChangePasswordRes changePasswordResFromJson(String str) => ChangePasswordRes.fromJson(json.decode(str));

    String changePasswordResToJson(ChangePasswordRes data) => json.encode(data.toJson());
}