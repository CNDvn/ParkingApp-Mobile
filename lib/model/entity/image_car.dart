class ImageCar {
  ImageCar({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory ImageCar.fromJson(Map<String, dynamic> json) => ImageCar(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
