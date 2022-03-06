import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class CountTime extends StatefulWidget {
  CountTime({Key? key}) : super(key: key);

  @override
  State<CountTime> createState() => _CountTimeState();
}

class _CountTimeState extends State<CountTime> {
  Duration duration = const Duration();
  Timer? timer;
  final pauseTime = const Duration();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void addTime() {
    final addSecond = 1;
    setState(() {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  String stopTimer() {
    setState(() {
      timer?.cancel();
    });
    var toalTime = timer?.tick;
    print(toalTime);
    return toalTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.whiteBackground,
        body: SingleChildScrollView(
            child: Column(
          children: [
            buildTime(),
            Container(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: size.width * 0.8,
                  child: ConfirmationSlider(onConfirmation: stopTimer),
                ))
          ],
        )));
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text('$hours:$minutes:$seconds', style: AppTextStyles.h1Black);
  }
}
