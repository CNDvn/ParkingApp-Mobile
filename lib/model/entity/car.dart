import 'package:parkingappmobile/model/entity/image_car.dart';
import 'package:parkingappmobile/model/entity/type_car.dart';

class Car {
  Car({
    required this.id,
    required this.nPlates,
    required this.brand,
    required this.color,
    required this.modelCode,
    required this.images,
    required this.typeCar,
    required this.status,
  });

  String id;
  String nPlates;
  String brand;
  String color;
  String modelCode;
  List<ImageCar> images;
  TypeCar typeCar;
  String status;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        images: List<ImageCar>.from(
            json["images"].map((x) => ImageCar.fromJson(x))),
        typeCar: TypeCar.fromJson(json["typeCar"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "typeCar": typeCar.toJson(),
        "status": status,
      };
}
