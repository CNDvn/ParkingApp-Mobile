import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/view/google_map/google_map.dart';
import 'package:parkingappmobile/view/history/history.dart';
import 'package:parkingappmobile/view/home/home.dart';
import 'package:parkingappmobile/view/payments/payments.dart';
import 'package:parkingappmobile/view/setting/setting.dart';

int currentTab = 0;

Widget currentScreen = GoogleMap();

final List<Widget> screens = [GoogleMap(), Payments(), History(), Setting()];

final PageStorageBucket bucket = PageStorageBucket();

class IconButtonStyle extends StatelessWidget {
  const IconButtonStyle(
      {Key? key,
      required this.voidCallback,
      required this.icon,
      required this.currentTab,
      required this.tab})
      : super(key: key);
  final VoidCallback voidCallback;
  final IconData icon;
  final int currentTab;
  final int tab;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: voidCallback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentTab == tab
                ? AppColor.lightButton
                : AppColor.greyBackground,
            size: 30,
          ),
        ],
      ),
    );
  }
}

final List<IconData> iconMid = [
  Icons.near_me_sharp,
  Icons.qr_code_2,
  Icons.query_builder,
  Icons.build_rounded
];

class ActionButtonMid extends StatelessWidget {
  const ActionButtonMid({Key? key, required this.currentTab}) : super(key: key);
  final int currentTab;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColor.lightButton,
        child: Icon(iconMid[currentTab], size: 36),
        onPressed: () {});
  }
}
