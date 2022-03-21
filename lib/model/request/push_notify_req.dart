// To parse this JSON data, do
//
//     final pushNotifyReq = pushNotifyReqFromJson(jsonString);

import 'dart:convert';

class PushNotifyReq {
  PushNotifyReq({
    this.token,
  });

  String? token;

  factory PushNotifyReq.fromJson(Map<String, dynamic> json) => PushNotifyReq(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
  static PushNotifyReq pushNotifyReqFromJson(String str) =>
      PushNotifyReq.fromJson(json.decode(str));

  static String pushNotifyReqToJson(PushNotifyReq data) =>
      json.encode(data.toJson());
}
