// To parse this JSON data, do
//
//     final parking = parkingFromJson(jsonString);

import 'dart:convert';

import 'package:parkingappmobile/model/entity/business.dart';
import 'package:parkingappmobile/model/entity/image.dart';

Parking parkingFromJson(String str) => Parking.fromJson(json.decode(str));

String parkingToJson(Parking data) => json.encode(data.toJson());

class Parking {
  Parking({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.status,
    required this.phoneNumber,
    required this.business,
    required this.images,
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
  Coordinatess coordinates;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
        business: Business.fromJson(json["business"]),
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        coordinates: Coordinatess.fromJson(json["coordinates"]),
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
        "coordinates": coordinates.toJson(),
      };
}

class Coordinatess {
  Coordinatess({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Coordinatess.fromJson(Map<String, dynamic> json) => Coordinatess(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
