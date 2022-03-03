// To parse this JSON data, do
//
//     final profileRes = profileResFromJson(jsonString);

import 'dart:convert';

class ProfileRes {
  ProfileRes({
    this.result,
    this.statusCode,
  });

  String? result;
  int? statusCode;

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
      };

  static ProfileRes profileResFromJson(String str) =>
      ProfileRes.fromJson(json.decode(str));

  String profileResToJson(ProfileRes data) => json.encode(data.toJson());
}
