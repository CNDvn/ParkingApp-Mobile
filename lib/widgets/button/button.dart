import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault(
      {Key? key,
      this.width = 342,
      this.height = 56,
      required this.content,
      this.color,
      required this.voidCallBack})
      : super(key: key);
  final double? width;
  final double? height;
  final String content;
  final Color? color;
  final VoidCallback voidCallBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: voidCallBack,
        child: Text(
          content,
          style: TextStyle(color: AppColor.whiteText),
        ),
        style: ElevatedButton.styleFrom(primary: AppColor.lightButton),
      ),
    );
  }
}
