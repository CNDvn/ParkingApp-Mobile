import 'package:parkingappmobile/model/entity/image.dart';
import 'package:parkingappmobile/model/entity/type_car.dart';

class Car {
  Car({
    this.id,
    this.nPlates,
    this.brand,
    this.color,
    this.modelCode,
    this.images,
    this.typeCar,
    this.status,
  });

  String? id;
  String? nPlates;
  String? brand;
  String? color;
  String? modelCode;
  List<Images>? images;
  TypeCar? typeCar;
  String? status;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        typeCar: TypeCar.fromJson(json["typeCar"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "typeCar": typeCar?.toJson(),
        "status": status,
      };
}