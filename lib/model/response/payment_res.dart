// To parse this JSON data, do
//
//     final paymentRes = paymentResFromJson(jsonString);

import 'dart:convert';

class PaymentRes {
  PaymentRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory PaymentRes.fromJson(Map<String, dynamic> json) => PaymentRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };
  static PaymentRes paymentResFromJson(String str) =>
      PaymentRes.fromJson(json.decode(str));

  String paymentResToJson(PaymentRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.amount,
    this.walletTo,
    this.walletForm,
    this.payment,
    this.createdBy,
    this.updatedBy,
    this.description,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  String? amount;
  WalletTo? walletTo;
  WalletForm? walletForm;
  Payment? payment;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic description;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? date;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        amount: json["amount"],
        walletTo: WalletTo.fromJson(json["walletTo"]),
        walletForm: WalletForm.fromJson(json["walletForm"]),
        payment: Payment.fromJson(json["payment"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        description: json["description"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "walletTo": walletTo?.toJson(),
        "walletForm": walletForm?.toJson(),
        "payment": payment?.toJson(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "description": description,
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "date": date?.toIso8601String(),
      };
}

class Payment {
  Payment({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.amount,
    this.endTime,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? amount;
  DateTime? endTime;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        amount: json["amount"],
        endTime: DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "amount": amount,
        "endTime": endTime?.toIso8601String(),
      };
}

class WalletForm {
  WalletForm({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.currentBalance,
    this.frozenMoney,
    this.expiredTime,
    this.createdTime,
    this.user,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic currentBalance;
  dynamic frozenMoney;
  DateTime? expiredTime;
  DateTime? createdTime;
  User? user;

  factory WalletForm.fromJson(Map<String, dynamic> json) => WalletForm(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        currentBalance: json["currentBalance"],
        frozenMoney: json["frozenMoney"],
        expiredTime: DateTime.parse(json["expiredTime"]),
        createdTime: DateTime.parse(json["createdTime"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "currentBalance": currentBalance,
        "frozenMoney": frozenMoney,
        "expiredTime": expiredTime?.toIso8601String(),
        "createdTime": createdTime?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.firstName,
    this.lastName,
    this.dob,
    this.status,
    this.username,
    this.password,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.phoneNumberVerifyCode,
    this.phoneNumberVerifyCodeExpire,
    this.email,
    this.address,
    this.avatar,
    this.refreshToken,
    this.role,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? firstName;
  String? lastName;
  DateTime? dob;
  String? status;
  String? username;
  String? password;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  int? phoneNumberVerifyCode;
  DateTime? phoneNumberVerifyCodeExpire;
  String? email;
  String? address;
  String? avatar;
  String? refreshToken;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: DateTime.parse(json["DOB"]),
        status: json["status"],
        username: json["username"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        // ignore: prefer_if_null_operators
        phoneNumberVerifyCode: json["phoneNumberVerifyCode"] == null
            ? null
            : json["phoneNumberVerifyCode"],
        phoneNumberVerifyCodeExpire: json["phoneNumberVerifyCodeExpire"] == null
            ? null
            : DateTime.parse(json["phoneNumberVerifyCodeExpire"]),
        email: json["email"],
        address: json["address"],
        avatar: json["avatar"],
        refreshToken: json["refreshToken"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "firstName": firstName,
        "lastName": lastName,
        "DOB":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "status": status,
        "username": username,
        "password": password,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        // ignore: prefer_if_null_operators
        "phoneNumberVerifyCode":
            // ignore: prefer_if_null_operators
            phoneNumberVerifyCode == null ? null : phoneNumberVerifyCode,
        // ignore: prefer_null_aware_operators
        "phoneNumberVerifyCodeExpire": phoneNumberVerifyCodeExpire == null
            ? null
            : phoneNumberVerifyCodeExpire?.toIso8601String(),
        "email": email,
        "address": address,
        "avatar": avatar,
        "refreshToken": refreshToken,
        "role": role?.toJson(),
      };
}

class Role {
  Role({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.name,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
      };
}

class WalletTo {
  WalletTo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.currentBalance,
    this.frozenMoney,
    this.expiredTime,
    this.createdTime,
    this.user,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic currentBalance;
  dynamic frozenMoney;
  DateTime? expiredTime;
  DateTime? createdTime;
  User? user;

  factory WalletTo.fromJson(Map<String, dynamic> json) => WalletTo(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        currentBalance: json["currentBalance"],
        frozenMoney: json["frozenMoney"],
        expiredTime: DateTime.parse(json["expiredTime"]),
        createdTime: DateTime.parse(json["createdTime"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "currentBalance": currentBalance,
        "frozenMoney": frozenMoney,
        "expiredTime": expiredTime?.toIso8601String(),
        "createdTime": createdTime?.toIso8601String(),
        "user": user?.toJson(),
      };
}
