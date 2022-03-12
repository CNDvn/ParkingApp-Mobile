// To parse this JSON data, do
//
//     final myCarRes = myCarResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/car.dart';

class MyCarRes {
  MyCarRes({
    this.result,
    this.statusCode,
  });

  List<Car>? result;
  int? statusCode;

  factory MyCarRes.fromJson(Map<String, dynamic> json) => MyCarRes(
        result:
            List<Car>.from(json["result"].map((x) => Car.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static MyCarRes myCarResFromJson(String str) =>
      MyCarRes.fromJson(json.decode(str));

  String myCarResToJson(MyCarRes data) => json.encode(data.toJson());
}