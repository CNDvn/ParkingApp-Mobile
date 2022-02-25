// To parse this JSON data, do
//
//     final usersMeRes = usersMeResFromJson(jsonString);

import 'dart:convert';

UsersMeRes usersMeResFromJson(String str) =>
    UsersMeRes.fromJson(json.decode(str));

String usersMeResToJson(UsersMeRes data) => json.encode(data.toJson());

class UsersMeRes {
  UsersMeRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory UsersMeRes.fromJson(Map<String, dynamic> json) => UsersMeRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static UsersMeRes usersMeResFromJson(String str) => UsersMeRes.fromJson(json.decode(str));
}

class Result {
  Result({
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
    required this.customer,
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
  Customer customer;
  Role role;
  String fullName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
        customer: Customer.fromJson(json["customer"]),
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
        "customer": customer.toJson(),
        "role": role.toJson(),
        "fullName": fullName,
      };
}

class Customer {
  Customer({
    required this.level,
  });

  int level;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
      };
}

class Role {
  Role({
    required this.name,
  });

  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}