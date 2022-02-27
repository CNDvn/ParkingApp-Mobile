// To parse this JSON data, do
//
//     final changePasswordReq = changePasswordReqFromJson(jsonString);

import 'dart:convert';

ChangePasswordReq changePasswordReqFromJson(String str) => ChangePasswordReq.fromJson(json.decode(str));

String changePasswordReqToJson(ChangePasswordReq data) => json.encode(data.toJson());

class ChangePasswordReq {
    ChangePasswordReq({
        required this.password,
        required this.newPassword,
    });

    String password;
    String newPassword;

    factory ChangePasswordReq.fromJson(Map<String, dynamic> json) => ChangePasswordReq(
        password: json["password"],
        newPassword: json["newPassword"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "newPassword": newPassword,
    };
}