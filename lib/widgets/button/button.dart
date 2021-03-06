import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';

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
        child: Text(content, style: AppTextStyles.h3Bold),
        style: ElevatedButton.styleFrom(
          primary: AppColor.lightButton,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
