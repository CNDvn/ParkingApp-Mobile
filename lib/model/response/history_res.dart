// To parse this JSON data, do
//
//     final historyRes = historyResFromJson(jsonString);

import 'dart:convert';

class HistoryRes {
  HistoryRes({
    this.result,
    this.statusCode,
  });

  List<Result>? result;
  int? statusCode;

  factory HistoryRes.fromJson(Map<String, dynamic> json) => HistoryRes(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static HistoryRes historyResFromJson(String str) =>
      HistoryRes.fromJson(json.decode(str));

  String historyResToJson(HistoryRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.startTime,
    required this.checkinTime,
    required this.status,
    required this.price,
    required this.service,
    required this.parkingSlot,
    required this.payment,
    required this.car,
    required this.parking,
  });

  String id;
  String startTime;
  String checkinTime;
  String status;
  String price;
  dynamic service;
  ParkingSlot parkingSlot;
  Payment payment;
  CarHistory car;
  Parking parking;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        startTime: json["startTime"],
        checkinTime: json["checkinTime"],
        status: json["status"],
        price: json["price"],
        service: json["service"],
        parkingSlot: ParkingSlot.fromJson(json["parkingSlot"]),
        payment: Payment.fromJson(json["payment"]??json["car"]),
        car: CarHistory.fromJson(json["car"]),
        parking: Parking.fromJson(json["parking"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "checkinTime": checkinTime,
        "status": status,
        "price": price,
        "service": service,
        "parkingSlot": parkingSlot.toJson(),
        "payment": payment.toJson(),
        "car": car.toJson(),
        "parking": parking.toJson(),
      };
}

class CarHistory {
  CarHistory({
    required this.id,
    required this.nPlates,
    required this.brand,
    required this.color,
    required this.modelCode,
    required this.status,
  });

  String id;
  String nPlates;
  String brand;
  String color;
  String modelCode;
  String status;

  factory CarHistory.fromJson(Map<String, dynamic> json) => CarHistory(
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
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.status,
    required this.phoneNumber,
  });

  String id;
  String name;
  String address;
  String openTime;
  String closeTime;
  String status;
  String phoneNumber;

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
    required this.id,
    required this.locationName,
    required this.status,
  });

  String id;
  String locationName;
  String status;

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

class Payment {
  Payment({
    required this.id,
    required this.amount,
    required this.endTime,
  });

  String id;
  String amount;
  String endTime;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: json["amount"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "endTime": endTime,
      };
}
