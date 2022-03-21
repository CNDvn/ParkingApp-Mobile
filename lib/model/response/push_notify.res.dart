// To parse this JSON data, do
//
//     final pushNotifyRes = pushNotifyResFromJson(jsonString);

import 'dart:convert';

class PushNotifyRes {
  PushNotifyRes({
    this.result,
    this.statusCode,
  });

  String? result;
  int? statusCode;

  factory PushNotifyRes.fromJson(Map<String, dynamic> json) => PushNotifyRes(
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
      };
  static PushNotifyRes pushNotifyResFromJson(String str) =>
      PushNotifyRes.fromJson(json.decode(str));

  static String pushNotifyResToJson(PushNotifyRes data) =>
      json.encode(data.toJson());
}
