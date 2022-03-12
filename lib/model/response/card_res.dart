// To parse this JSON data, do
//
//     final listCard = listCardFromJson(jsonString);

import 'dart:convert';

class ListCard {
  ListCard({
    this.result,
    this.statusCode,
  });

  List<CardBank>? result;
  int? statusCode;

  factory ListCard.fromJson(Map<String, dynamic> json) => ListCard(
        result: List<CardBank>.from(
            json["result"].map((x) => CardBank.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
  static ListCard listCardFromJson(String str) =>
      ListCard.fromJson(json.decode(str));

  String listCardToJson(ListCard data) => json.encode(data.toJson());
}

class CardBank {
  CardBank({
    required this.id,
    required this.dateValidFrom,
    required this.cardNumber,
    required this.cardHolder,
  });

  String id;
  String dateValidFrom;
  String cardNumber;
  String cardHolder;

  factory CardBank.fromJson(Map<String, dynamic> json) => CardBank(
        id: json["id"],
        dateValidFrom: json["dateValidFrom"],
        cardNumber: json["cardNumber"],
        cardHolder: json["cardHolder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateValidFrom": dateValidFrom,
        "cardNumber": cardNumber,
        "cardHolder": cardHolder,
      };
}
