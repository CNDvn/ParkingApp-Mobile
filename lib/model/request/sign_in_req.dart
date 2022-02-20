// To parse this JSON data, do
//
//     final signInRequest = signInRequestFromJson(jsonString);

import 'dart:convert';

SignInReq signInRequestFromJson(String str) => SignInReq.fromJson(json.decode(str));

String signInRequestToJson(SignInReq data) => json.encode(data.toJson());

class SignInReq {
    SignInReq({
      required this.username,
      required this.password,
      required this.role,
    });

    String username;
    String password;
    String role;

    factory SignInReq.fromJson(Map<String, dynamic> json) => SignInReq(
        username: json["username"],
        password: json["password"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "role": role,
    };
}
