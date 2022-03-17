// To parse this JSON data, do
//
//     final bookingByIdCarRes1 = bookingByIdCarRes1FromJson(jsonString);

import 'dart:convert';

class BookingByIdCarRes1 {
  BookingByIdCarRes1({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory BookingByIdCarRes1.fromJson(Map<String, dynamic> json) =>
      BookingByIdCarRes1(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static BookingByIdCarRes1 bookingByIdCarRes1FromJson(String str) =>
      BookingByIdCarRes1.fromJson(json.decode(str));

  String bookingByIdCarRes1ToJson(BookingByIdCarRes1 data) =>
      json.encode(data.toJson());
}

class Result {
  Result({
    this.id,
    this.startTime,
    this.checkinTime,
    this.status,
    this.price,
    this.service,
    this.parkingSlot,
    this.payment,
    this.car,
    this.parking,
  });

  String? id;
  DateTime? startTime;
  DateTime? checkinTime;
  String? status;
  String? price;
  dynamic service;
  ParkingSlot? parkingSlot;
  dynamic payment;
  Car? car;
  Parking? parking;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        checkinTime: DateTime.parse(json["checkinTime"]??json["startTime"]),
        status: json["status"],
        price: json["price"],
        service: json["service"],
        parkingSlot: ParkingSlot.fromJson(json["parkingSlot"]),
        payment: json["payment"],
        car: Car.fromJson(json["car"]),
        parking: Parking.fromJson(json["parking"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime?.toIso8601String(),
        "checkinTime": checkinTime?.toIso8601String(),
        "status": status,
        "price": price,
        "service": service,
        "parkingSlot": parkingSlot?.toJson(),
        "payment": payment,
        "car": car?.toJson(),
        "parking": parking?.toJson(),
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

class Parking {
  Parking({
    this.id,
    this.name,
    this.address,
    this.openTime,
    this.closeTime,
    this.status,
    this.phoneNumber,
  });

  String? id;
  String? name;
  String? address;
  String? openTime;
  String? closeTime;
  String? status;
  String? phoneNumber;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "openTime": openTime,
        "closeTime": closeTime,
        "status": status,
        "phoneNumber": phoneNumber,
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
