// To parse this JSON data, do
//
//     final checkoutRes = checkoutResFromJson(jsonString);

import 'dart:convert';

class CheckoutRes {
  CheckoutRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory CheckoutRes.fromJson(Map<String, dynamic> json) => CheckoutRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };
  static CheckoutRes checkoutResFromJson(String str) =>
      CheckoutRes.fromJson(json.decode(str));

  String checkoutResToJson(CheckoutRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.booking,
    this.endTime,
    this.amount,
    this.createdBy,
    this.updatedBy,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Booking? booking;
  DateTime? endTime;
  dynamic amount;
  dynamic createdBy;
  dynamic updatedBy;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        booking: Booking.fromJson(json["booking"]),
        endTime: DateTime.parse(json["endTime"]),
        amount: json["amount"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "booking": booking?.toJson(),
        "endTime": endTime?.toIso8601String(),
        "amount": amount,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Booking {
  Booking({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.startTime,
    this.checkinTime,
    this.status,
    this.price,
    this.service,
    this.parking,
    this.parkingSlot,
    this.payment,
    this.car,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? startTime;
  DateTime? checkinTime;
  String? status;
  String? price;
  dynamic service;
  Parking? parking;
  ParkingSlot? parkingSlot;
  dynamic payment;
  Car? car;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        startTime: DateTime.parse(json["startTime"]),
        checkinTime: DateTime.parse(json["checkinTime"]),
        status: json["status"],
        price: json["price"],
        service: json["service"],
        parking: Parking.fromJson(json["parking"]),
        parkingSlot: ParkingSlot.fromJson(json["parkingSlot"]),
        payment: json["payment"],
        car: Car.fromJson(json["car"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "startTime": startTime?.toIso8601String(),
        "checkinTime": checkinTime?.toIso8601String(),
        "status": status,
        "price": price,
        "service": service,
        "parking": parking?.toJson(),
        "parkingSlot": parkingSlot?.toJson(),
        "payment": payment,
        "car": car?.toJson(),
      };
}

class Car {
  Car({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.nPlates,
    this.brand,
    this.color,
    this.modelCode,
    this.status,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  dynamic updatedBy;
  String? nPlates;
  String? brand;
  String? color;
  String? modelCode;
  String? status;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
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
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.address,
    this.coordinate,
    this.openTime,
    this.closeTime,
    this.status,
    this.phoneNumber,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  dynamic updatedBy;
  String? name;
  String? address;
  Coordinate? coordinate;
  String? openTime;
  String? closeTime;
  String? status;
  String? phoneNumber;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        address: json["address"],
        coordinate: Coordinate.fromJson(json["coordinate"]),
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
        "address": address,
        "coordinate": coordinate?.toJson(),
        "openTime": openTime,
        "closeTime": closeTime,
        "status": status,
        "phoneNumber": phoneNumber,
      };
}

class Coordinate {
  Coordinate({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class ParkingSlot {
  ParkingSlot({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.locationName,
    this.status,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  dynamic updatedBy;
  String? locationName;
  String? status;

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        locationName: json["locationName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "locationName": locationName,
        "status": status,
      };
}
