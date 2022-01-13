import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

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

    slides.add(
      new Slide(
        title: 'Best Parking Spots',
        styleTitle: TextStyle(
            color: AppColor.blackText, fontSize: 24.0, fontWeight: FontWeight.bold),
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        styleDescription: TextStyle(color: AppColor.greyText, fontSize: 18.0),
        pathImage: '${AssetPath.welcome1}',
        backgroundColor: AppColor.whiteBackground,
      ),
    );
    slides.add(
      new Slide(
        title: 'Quick Navigation',
        styleTitle: TextStyle(
            color: AppColor.blackText, fontSize: 24.0, fontWeight: FontWeight.bold),
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        styleDescription: TextStyle(color: AppColor.greyText, fontSize: 18.0),
        pathImage: '${AssetPath.welcome2}',
        backgroundColor: AppColor.whiteBackground,
      ),
    );
    slides.add(
      new Slide(
        title: 'Easy Payment',
        styleTitle: TextStyle(
            color: AppColor.blackText, fontSize: 24.0, fontWeight: FontWeight.bold),
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        styleDescription: TextStyle(color: AppColor.greyText, fontSize: 18.0),
        pathImage: '${AssetPath.welcome3}',
        backgroundColor: AppColor.whiteBackground,
      ),
    );
  }

  void onDonePress() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      overlayColor: MaterialStateProperty.all<Color>(AppColor.blueBackground),
    );
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
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: Text(
        'NEXT',
        style: TextStyle(color: AppColor.blueText),
      ),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: Text(
        'DONE',
        style: TextStyle(color: AppColor.blueText),
      ),
      doneButtonStyle: myButtonStyle(),
      onDonePress: this.onDonePress,

      // Dot indicator
      colorDot: AppColor.greyBackground,
      colorActiveDot: AppColor.blackText,
      sizeDot: 8.0,
    );
  }
}
