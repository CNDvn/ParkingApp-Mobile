// To parse this JSON data, do
//
//     final resetPasswordRes = resetPasswordResFromJson(jsonString);

import 'dart:convert';



class ResetPasswordRes {
    ResetPasswordRes({
        this.statusCode,
        this.message,
    });

    int? statusCode;
    String? message;

    factory ResetPasswordRes.fromJson(Map<String, dynamic> json) => ResetPasswordRes(
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
    };

    static ResetPasswordRes resetPasswordResFromJson(String str) => ResetPasswordRes.fromJson(json.decode(str));

    String resetPasswordResToJson(ResetPasswordRes data) => json.encode(data.toJson());
}