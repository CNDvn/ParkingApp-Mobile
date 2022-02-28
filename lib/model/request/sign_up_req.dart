// To parse this JSON data, do
//
//     final signUpReq = signUpReqFromJson(jsonString);

import 'dart:convert';

SignUpReq signUpReqFromJson(String str) => SignUpReq.fromJson(json.decode(str));

String signUpReqToJson(SignUpReq data) => json.encode(data.toJson());

class SignUpReq {
  SignUpReq({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatar,
  });

  String firstName;
  String lastName;
  String dob;
  String username;
  String password;
  String phoneNumber;
  String email;
  String address;
  String avatar;

  factory SignUpReq.fromJson(Map<String, dynamic> json) => SignUpReq(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["DOB"],
        username: json["username"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob,
        "username": username,
        "password": password,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
      };
}
