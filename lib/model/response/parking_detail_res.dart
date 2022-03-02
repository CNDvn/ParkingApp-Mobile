// To parse this JSON data, do
//
//     final parkingDetailRes = parkingDetailResFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/image.dart';

class ParkingDetailRes {
    ParkingDetailRes({
        this.result,
        this.statusCode,
    });

    Result? result;
    int? statusCode;

    factory ParkingDetailRes.fromJson(Map<String, dynamic> json) => ParkingDetailRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
    };

    static ParkingDetailRes parkingDetailResFromJson(String str) => ParkingDetailRes.fromJson(json.decode(str));

    String parkingDetailResToJson(ParkingDetailRes data) => json.encode(data.toJson());
}

class Result {
    Result({
        required this.id,
        required this.name,
        required this.address,
        required this.openTime,
        required this.closeTime,
        required this.status,
        required this.phoneNumber,
        required this.business,
        required this.images,
        required this.parkingSlots,
        required this.coordinates,
    });

    String id;
    String name;
    String address;
    String openTime;
    String closeTime;
    String status;
    String phoneNumber;
    Business business;
    List<Images> images;
    List<dynamic> parkingSlots;
    Coordinates coordinates;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
        business: Business.fromJson(json["business"]),
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        parkingSlots: List<dynamic>.from(json["parkingSlots"].map((x) => x)),
        coordinates: Coordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "openTime": openTime,
        "closeTime": closeTime,
        "status": status,
        "phoneNumber": phoneNumber,
        "business": business.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "parkingSlots": List<dynamic>.from(parkingSlots.map((x) => x)),
        "coordinates": coordinates.toJson(),
    };
}

class Business {
    Business({
        this.user,
    });

    User? user;

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
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
        this.id,
        this.name,
    });

    String? id;
    String? name;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Coordinates {
    Coordinates({
        this.latitude,
        this.longitude,
    });

    double? latitude;
    double? longitude;

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Image {
    Image({
        this.url,
    });

    String? url;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
