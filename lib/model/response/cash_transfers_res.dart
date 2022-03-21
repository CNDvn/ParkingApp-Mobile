// To parse this JSON data, do
//
//     final cashTransfersRes = cashTransfersResFromJson(jsonString);

import 'dart:convert';

class CashTransfersRes {
  CashTransfersRes({
    this.result,
    this.statusCode,
  });

  String? result;
  int? statusCode;

  factory CashTransfersRes.fromJson(Map<String, dynamic> json) =>
      CashTransfersRes(
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
      };

  static CashTransfersRes cashTransfersResFromJson(String str) =>
      CashTransfersRes.fromJson(json.decode(str));

  String cashTransfersResToJson(CashTransfersRes data) =>
      json.encode(data.toJson());
}
