// To parse this JSON data, do
//
//     final uploadCarRes = uploadCarResFromJson(jsonString);

import 'dart:convert';

class UploadCarRes {
  UploadCarRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory UploadCarRes.fromJson(Map<String, dynamic> json) => UploadCarRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static UploadCarRes uploadCarResFromJson(String str) =>
      UploadCarRes.fromJson(json.decode(str));

  String uploadCarResToJson(UploadCarRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.nPlates,
    required this.brand,
    required this.color,
    required this.modelCode,
    required this.status,
  });

  String id;
  String nPlates;
  String brand;
  String color;
  String modelCode;
  String status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "status": status,
      };
}
