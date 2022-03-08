import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view_model/providers/tracking_car_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class CountTime extends StatefulWidget {
  const CountTime({Key? key}) : super(key: key);

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
    var addSecond = 1;
    setState(() {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  String stopTimer() {
    setState(() {
      timer?.cancel();
    });
    var toalTime = timer?.tick;
    log(toalTime.toString());
    return toalTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TrackingCarProvider provider = Provider.of<TrackingCarProvider>(context);
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
                  child: ConfirmationSlider(onConfirmation: (){
                    stopTimer;
                  }),
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
