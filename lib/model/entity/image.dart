class Images {
  Images({
    required this.url,
  });

  String url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
