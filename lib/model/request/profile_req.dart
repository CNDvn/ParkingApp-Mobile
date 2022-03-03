// To parse this JSON data, do
//
//     final ProfileReq = ProfileReqFromJson(jsonString);

import 'dart:convert';

ProfileReq profileRequestFromJson(String str) =>
    ProfileReq.fromJson(json.decode(str));

String profileRequestToJson(ProfileReq data) => json.encode(data.toJson());

class ProfileReq {
  ProfileReq({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatar,
  });

  String firstName;
  String lastName;
  String dob;
  String phoneNumber;
  String email;
  String address;
  String avatar;

  factory ProfileReq.fromJson(Map<String, dynamic> json) => ProfileReq(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["DOB"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
      };
}
