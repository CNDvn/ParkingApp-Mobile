// To parse this JSON data, do
//
//     final resetPasswordReq = resetPasswordReqFromJson(jsonString);

import 'dart:convert';

ResetPasswordReq resetPasswordReqFromJson(String str) => ResetPasswordReq.fromJson(json.decode(str));

String resetPasswordReqToJson(ResetPasswordReq data) => json.encode(data.toJson());

class ResetPasswordReq {
    ResetPasswordReq({
        required this.otp,
        required this.username,
    });

    int otp;
    String username;

    factory ResetPasswordReq.fromJson(Map<String, dynamic> json) => ResetPasswordReq(
        otp: json["otp"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
        "username": username,
    };
}