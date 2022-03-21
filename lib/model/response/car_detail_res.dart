// To parse this JSON data, do
//
//     final carDetailRes = carDetailResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/car.dart';



class CarDetailRes {
    CarDetailRes({
        this.result,
        this.statusCode,
    });

    Car? result;
    int? statusCode;

    factory CarDetailRes.fromJson(Map<String, dynamic> json) => CarDetailRes(
        result: Car.fromJson(json["result"]),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "statusCode": statusCode,
    };

    static CarDetailRes carDetailResFromJson(String str) => CarDetailRes.fromJson(json.decode(str));

    String carDetailResToJson(CarDetailRes data) => json.encode(data.toJson());
}
