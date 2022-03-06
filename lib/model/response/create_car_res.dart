// To parse this JSON data, do
//
//     final createCarRes = createCarResFromJson(jsonString);

import 'dart:convert';

class CreateCarRes {
  CreateCarRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory CreateCarRes.fromJson(Map<String, dynamic> json) => CreateCarRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static CreateCarRes createCarResFromJson(String str) =>
      CreateCarRes.fromJson(json.decode(str));

  String createCarResToJson(CreateCarRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.nPlates,
    required this.brand,
    required this.color,
    required this.modelCode,
    required this.images,
  });

  String id;
  String nPlates;
  String brand;
  String color;
  String modelCode;
  List<dynamic> images;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
