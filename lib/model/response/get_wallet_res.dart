// To parse this JSON data, do
//
//     final getWalletRes = getWalletResFromJson(jsonString);

import 'dart:convert';

class GetWalletRes {
  GetWalletRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory GetWalletRes.fromJson(Map<String, dynamic> json) => GetWalletRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static GetWalletRes getWalletResFromJson(String str) =>
      GetWalletRes.fromJson(json.decode(str));

  String getWalletResToJson(GetWalletRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.id,
    this.currentBalance,
    this.frozenMoney,
    this.expiredTime,
    this.createdTime,
    this.user,
  });

  String? id;
  String? currentBalance;
  String? frozenMoney;
  String? expiredTime;
  String? createdTime;
  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        currentBalance: json["currentBalance"],
        frozenMoney: json["frozenMoney"],
        expiredTime: json["expiredTime"],
        createdTime: json["createdTime"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currentBalance": currentBalance,
        "frozenMoney": frozenMoney,
        "expiredTime": expiredTime,
        "createdTime": createdTime,
        "user": user?.toJson(),
      };

  static Result getWalletResultResFromJson(String str) =>
      Result.fromJson(json.decode(str));

  String getWalletResultResToJson(Result data) => json.encode(data.toJson());
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.status,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatar,
    required this.role,
    required this.fullName,
  });

  String id;
  String firstName;
  String lastName;
  DateTime dob;
  String status;
  String username;
  String phoneNumber;
  String email;
  String address;
  String avatar;
  Role role;
  String fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: DateTime.parse(json["DOB"]),
        status: json["status"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        avatar: json["avatar"],
        role: Role.fromJson(json["role"]),
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob.toIso8601String(),
        "status": status,
        "username": username,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
        "role": role.toJson(),
        "fullName": fullName,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
