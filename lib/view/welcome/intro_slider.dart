import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view/welcome/data_slides.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({Key? key}) : super(key: key);

  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataSlides.forEach((slide) => {
          slides.add(
            new Slide(
              title: slide.title,
              styleTitle: AppTextStyles.h2Black,
              description: slide.description,
              styleDescription:
                  TextStyle(color: AppColor.greyText, fontSize: 18.0),
              pathImage: slide.pathImage,
              backgroundColor: AppColor.whiteBackground,
            ),
          )
        });
  }

  void onDonePress() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: Text(
        'SKIP',
        style: TextStyle(color: AppColor.blueBackground),
      ),
      skipButtonStyle: dotButtonStyle(),

      // Next button
      renderNextBtn: Text(
        'NEXT',
        style: TextStyle(color: AppColor.blueText),
      ),
      nextButtonStyle: dotButtonStyle(),

      // Done button
      renderDoneBtn: Text(
        'DONE',
        style: TextStyle(color: AppColor.blueText),
      ),
      doneButtonStyle: dotButtonStyle(),
      onDonePress: this.onDonePress,

      // Dot indicator
      colorDot: AppColor.greyBackground,
      colorActiveDot: AppColor.blackText,
      sizeDot: 8.0,
    );
  }
}
