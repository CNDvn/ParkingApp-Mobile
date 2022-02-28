import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderImage extends StatelessWidget {
  const CarouselSliderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final urlImages = [
      'https://thuexerangdong.com/wp-content/uploads/2020/06/gia-gui-xe-o-to-thang-tphcm-luon-la-mot-trong-nhung-moi-quan-tam-hang-dau-hien-nay-doi-voi-nhung-ai-dang-va-se-so-huu-o-to-rieng.jpg',
      'https://spmgroup.vn/wp-content/uploads/2019/05/5-1.jpg',
      'https://xehyundaidanang.net/UploadImages/news/dau-xe-dung-cach/do-xe-khoa-hoc.jpg',
    ];
    return CarouselSlider.builder(
      itemCount: urlImages.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = urlImages[index];
        return buildImage(urlImage, index);
      },
      options: CarouselOptions(
        height: size.height * 0.3,
        viewportFraction: 1,
        autoPlay: urlImages.length > 1 ? true : false,
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
