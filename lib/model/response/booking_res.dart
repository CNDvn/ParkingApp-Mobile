// To parse this JSON data, do
//
//     final bookingRes = bookingResFromJson(jsonString);

import 'dart:convert';

class BookingRes {
  BookingRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory BookingRes.fromJson(Map<String, dynamic> json) => BookingRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };
  static BookingRes bookingResFromJson(String str) =>
      BookingRes.fromJson(json.decode(str));

  String bookingResToJson(BookingRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.id,
    this.startTime,
    this.status,
    this.price,
    this.service,
    this.parkingSlot,
    this.payments,
    this.car,
  });

  String? id;
  DateTime? startTime;
  String? status;
  String? price;
  dynamic service;
  ParkingSlot? parkingSlot;
  Payments? payments;
  Car? car;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        status: json["status"],
        price: json["price"],
        service: json["service"],
        parkingSlot: ParkingSlot.fromJson(json["parkingSlot"]),
        payments: Payments.fromJson(json["payments"]),
        car: Car.fromJson(json["car"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime?.toIso8601String(),
        "status": status,
        "price": price,
        "service": service,
        "parkingSlot": parkingSlot?.toJson(),
        "payments": payments?.toJson(),
        "car": car?.toJson(),
      };
}

class Car {
  Car({
    this.id,
    this.nPlates,
    this.brand,
    this.color,
    this.modelCode,
    this.status,
  });

  String? id;
  String? nPlates;
  String? brand;
  String? color;
  String? modelCode;
  String? status;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "status": status,
      };
}

class ParkingSlot {
  ParkingSlot({
    this.id,
    this.locationName,
    this.status,
  });

  String? id;
  String? locationName;
  String? status;

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        id: json["id"],
        locationName: json["locationName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locationName": locationName,
        "status": status,
      };
}

class Payments {
  Payments();

  factory Payments.fromJson(Map<String, dynamic> json) => Payments();

  Map<String, dynamic> toJson() => {};
}
