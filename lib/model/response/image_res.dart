// To parse this JSON data, do
//
//     final imageRes = imageResFromJson(jsonString);

import 'dart:convert';

ImageRes imageResFromJson(String str) => ImageRes.fromJson(json.decode(str));

String imageResToJson(ImageRes data) => json.encode(data.toJson());

class ImageRes {
  ImageRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory ImageRes.fromJson(Map<String, dynamic> json) => ImageRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static ImageRes imageResFromJson(String str) =>
      ImageRes.fromJson(json.decode(str));

  String imageResToJson(ImageRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.urlViewer,
    required this.url,
    required this.displayUrl,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String createdBy;
  String title;
  String urlViewer;
  String url;
  String displayUrl;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdBy: json["createdBy"],
        title: json["title"],
        urlViewer: json["urlViewer"],
        url: json["url"],
        displayUrl: json["displayUrl"],
        updatedBy: json["updatedBy"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "title": title,
        "urlViewer": urlViewer,
        "url": url,
        "displayUrl": displayUrl,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
