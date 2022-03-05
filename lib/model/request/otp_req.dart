// To parse this JSON data, do
//
//     final otpReq = otpReqFromJson(jsonString);

import 'dart:convert';

OtpReq otpReqFromJson(String str) => OtpReq.fromJson(json.decode(str));

String otpReqToJson(OtpReq data) => json.encode(data.toJson());

class OtpReq {
    OtpReq({
        required this.username,
    });

    String username;

    factory OtpReq.fromJson(Map<String, dynamic> json) => OtpReq(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}