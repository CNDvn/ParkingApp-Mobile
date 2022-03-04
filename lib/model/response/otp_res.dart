// To parse this JSON data, do
//
//     final otpRes = otpResFromJson(jsonString);

import 'dart:convert';

class OtpRes {
    OtpRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory OtpRes.fromJson(Map<String, dynamic> json) => OtpRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };

    static OtpRes otpResFromJson(String str) => OtpRes.fromJson(json.decode(str));

    String otpResToJson(OtpRes data) => json.encode(data.toJson());
}