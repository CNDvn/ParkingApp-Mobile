// To parse this JSON data, do
//
//     final uploadCarReq = uploadCarReqFromJson(jsonString);

import 'dart:convert';

UploadCarReq uploadCarReqFromJson(String str) =>
    UploadCarReq.fromJson(json.decode(str));

String uploadCarReqToJson(UploadCarReq data) => json.encode(data.toJson());

class UploadCarReq {
  UploadCarReq({
    required this.nPlates,
    required this.brand,
    required this.color,
    required this.modelCode,
    required this.typeCarId,
    required this.images,
  });

  String nPlates;
  String brand;
  String color;
  String modelCode;
  String typeCarId;
  List<String> images;

  factory UploadCarReq.fromJson(Map<String, dynamic> json) => UploadCarReq(
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        typeCarId: json["typeCarId"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "typeCarId": typeCarId,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
