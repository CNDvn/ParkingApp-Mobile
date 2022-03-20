// To parse this JSON data, do
//
//     final banksRes = banksResFromJson(jsonString);

import 'dart:convert';

class BanksRes {
  BanksRes({
    this.result,
    this.statusCode,
  });

  List<ResultBanks>? result;
  int? statusCode;

  factory BanksRes.fromJson(Map<String, dynamic> json) => BanksRes(
        result: List<ResultBanks>.from(
            json["result"].map((x) => ResultBanks.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static BanksRes banksResFromJson(String str) =>
      BanksRes.fromJson(json.decode(str));

  String banksResToJson(BanksRes data) => json.encode(data.toJson());
}

class ResultBanks {
  ResultBanks({
    this.id,
    this.name,
    this.bankCode,
  });

  String? id;
  String? name;
  String? bankCode;

  factory ResultBanks.fromJson(Map<String, dynamic> json) => ResultBanks(
        id: json["id"],
        name: json["name"],
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bankCode": bankCode,
      };
}
