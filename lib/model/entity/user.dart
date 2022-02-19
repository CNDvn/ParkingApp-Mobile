import 'package:parkingappmobile/model/entity/role.dart';

class User {
  User({
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
