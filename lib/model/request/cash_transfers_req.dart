// To parse this JSON data, do
//
//     final cashTransfersReq = cashTransfersReqFromJson(jsonString);

import 'dart:convert';

CashTransfersReq cashTransfersReqFromJson(String str) =>
    CashTransfersReq.fromJson(json.decode(str));

String cashTransfersReqToJson(CashTransfersReq data) =>
    json.encode(data.toJson());

class CashTransfersReq {
  CashTransfersReq({
    required this.amount,
    required this.bankId,
  });

  int amount;
  String bankId;

  factory CashTransfersReq.fromJson(Map<String, dynamic> json) =>
      CashTransfersReq(
        amount: json["amount"],
        bankId: json["bankId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "bankId": bankId,
      };
}
