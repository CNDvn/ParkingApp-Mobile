import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

class Slides {
  final String title, description, pathImage;

  const Slides({
    required this.title,
    required this.description,
    required this.pathImage,
  });
}

List<Slides> dataSlides = [
  const Slides(
      title: 'Best Parking Spots',
      description: 'Reserve a space with a few taps and skip the parking hunt',
      pathImage: AssetPath.welcomeOne),
  const Slides(
      title: 'Quick Navigation',
      description: 'Park your car in seconds and go do your thing',
      pathImage: AssetPath.welcomeTwo),
  const Slides(
      title: 'Easy Payment',
      description:
          'Compare prices, see your total cost up-front, and save up to 50%',
      pathImage: AssetPath.welcomeThree),
];

ButtonStyle dotButtonStyle() {
  return ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
    overlayColor: MaterialStateProperty.all<Color>(AppColor.blueBackground),
  );
}
