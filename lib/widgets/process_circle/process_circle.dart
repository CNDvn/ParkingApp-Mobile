import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

class ProcessCircle extends StatelessWidget {
  const ProcessCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.whiteBackground,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Lottie.asset(AssetPath.processWatting),
              ),
            ]),
      ),
    );
  }
}

void showDialogCustom(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColor.blueText,
        ),
      );
    });
