// To parse this JSON data, do
//
//     final createCarReq = createCarReqFromJson(jsonString);

import 'dart:convert';

CreateCarReq createCarReqFromJson(String str) =>
    CreateCarReq.fromJson(json.decode(str));

String createCarReqToJson(CreateCarReq data) => json.encode(data.toJson());

class CreateCarReq {
  CreateCarReq({
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

  factory CreateCarReq.fromJson(Map<String, dynamic> json) => CreateCarReq(
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
