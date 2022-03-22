// To parse this JSON data, do
//
//     final bookCancelRes = bookCancelResFromJson(jsonString);

import 'dart:convert';

class BookCancelRes {
    BookCancelRes({
        this.result,
        this.statusCode,
    });

    Result? result;
    int? statusCode;

    factory BookCancelRes.fromJson(Map<String, dynamic> json) => BookCancelRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
    };
    static BookCancelRes bookCancelResFromJson(String str) => BookCancelRes.fromJson(json.decode(str));

String bookCancelResToJson(BookCancelRes data) => json.encode(data.toJson());
}

class Result {
    Result({
        this.id,
        this.startTime,
        this.status,
        this.price,
        this.parkingSlot,
        this.payment,
        this.car,
        this.parking,
    });

    String? id;
    DateTime? startTime;
    String? status;
    String? price;
    ParkingSlot? parkingSlot;
    Payment? payment;
    Car? car;
    Parking? parking;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        status: json["status"],
        price: json["price"],
        parkingSlot: ParkingSlot.fromJson(json["parkingSlot"]),
        payment: Payment.fromJson(json["payment"]),
        car: Car.fromJson(json["car"]),
        parking: Parking.fromJson(json["parking"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime?.toIso8601String(),
        "status": status,
        "price": price,
        "parkingSlot": parkingSlot?.toJson(),
        "payment": payment?.toJson(),
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
        this.customer,
    });

    String? id;
    String? nPlates;
    String? brand;
    String? color;
    String? modelCode;
    String? status;
    Customer? customer;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        status: json["status"],
        customer: Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "status": status,
        "customer": customer?.toJson(),
    };
}

class Customer {
    Customer({
        this.id,
        this.level,
        this.user,
    });

    String? id;
    int? level;
    User? user;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        level: json["level"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "user": user?.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.dob,
        this.status,
        this.username,
        this.phoneNumber,
        this.email,
        this.address,
        this.avatar,
        this.fullName,
    });

    String? id;
    String? firstName;
    String? lastName;
    DateTime? dob;
    String? status;
    String? username;
    String? phoneNumber;
    String? email;
    String? address;
    String? avatar;
    String? fullName;

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
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob?.toIso8601String(),
        "status": status,
        "username": username,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
        "fullName": fullName,
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

class Payment {
    Payment({
        this.id,
        this.amount,
        this.endTime,
    });

    String? id;
    dynamic amount;
    DateTime? endTime;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: json["amount"],
        endTime: DateTime.parse(json["endTime"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "endTime": endTime?.toIso8601String(),
    };
}
