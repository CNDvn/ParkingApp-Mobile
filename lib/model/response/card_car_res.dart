// To parse this JSON data, do
//
//     final cardCarRes = cardCarResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/car.dart';

class CardCarRes {
    CardCarRes({
        this.result,
        this.statusCode,
    });

    List<Car>? result;
    int? statusCode;

    factory CardCarRes.fromJson(Map<String, dynamic> json) => CardCarRes(
        result: List<Car>.from(json["result"].map((x) => Car.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };

    static CardCarRes cardCarResFromJson(String str) => CardCarRes.fromJson(json.decode(str));

    String cardCarResToJson(CardCarRes data) => json.encode(data.toJson());
}

