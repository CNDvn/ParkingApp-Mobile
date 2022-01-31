import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/welcome/intro_slider.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';

class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) =>const IntroSliderPage()));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColor.whiteBackground,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: size.height * 0.15,
              child: Image.asset(AssetPath.logo)),
          Positioned(
              bottom: 0.0,
              width: size.width,
              child: Image.asset(AssetPath.posterCity)),
          const ProcessCircle(),
        ],
      ),
    );
  }
}