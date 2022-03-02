// To parse this JSON data, do
//
//     final loginGgReq = loginGgReqFromJson(jsonString);

import 'dart:convert';

class LoginGgReq {
  LoginGgReq({
    this.token,
  });

  String? token;

  factory LoginGgReq.fromJson(Map<String, dynamic> json) => LoginGgReq(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  LoginGgReq loginGgReqFromJson(String str) =>
      LoginGgReq.fromJson(json.decode(str));

  String loginGgReqToJson(LoginGgReq data) => json.encode(data.toJson());
}
