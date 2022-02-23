// To parse this JSON data, do
//
//     final parkingsRes = parkingsResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/parking.dart';

class ParkingsRes {
  ParkingsRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory ParkingsRes.fromJson(Map<String, dynamic> json) => ParkingsRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static ParkingsRes parkingsResFromJson(String str) =>
      ParkingsRes.fromJson(json.decode(str));

  String parkingsResToJson(ParkingsRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.data,
    this.count,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.lastPage,
  });

  List<Parking>? data;
  int? count;
  int? currentPage;
  int? nextPage;
  dynamic prevPage;
  int? lastPage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<Parking>.from(json["data"].map((x) => Parking.fromJson(x))),
        count: json["count"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        lastPage: json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "lastPage": lastPage,
      };
}
