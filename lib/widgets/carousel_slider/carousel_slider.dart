import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/entity/image.dart';

class CarouselSliderImage extends StatelessWidget {
  const CarouselSliderImage({
    Key? key,
    required this.urlImages,
  }) : super(key: key);

  final List<Images>? urlImages;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: urlImages!.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = urlImages![index];
        return buildImage(urlImage.url, index);
      },
      options: CarouselOptions(
        height: size.height * 0.3,
        viewportFraction: 1,
        autoPlay: urlImages!.length > 1 ? true : false,
        autoPlayInterval: const Duration(seconds: 2),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
