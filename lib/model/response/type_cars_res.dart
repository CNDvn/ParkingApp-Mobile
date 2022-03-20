// To parse this JSON data, do
//
//     final typeCarsRes = typeCarsResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/type_car.dart';

class TypeCarsRes {
  TypeCarsRes({
    this.result,
    this.statusCode,
  });

  List<TypeCar>? result;
  int? statusCode;

  factory TypeCarsRes.fromJson(Map<String, dynamic> json) => TypeCarsRes(
        result:
            List<TypeCar>.from(json["result"].map((x) => TypeCar.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static TypeCarsRes typeCarsResFromJson(String str) =>
      TypeCarsRes.fromJson(json.decode(str));

  String typeCarsResToJson(TypeCarsRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
