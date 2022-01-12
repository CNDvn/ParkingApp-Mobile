import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeImage = size.width * 0.08;
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150 / 2),
            child: Image.asset(
              AssetPath.posterCity,
              width: 100,
              height: 100,
            ),
          ),
        ),
        ListTile(
          leading: Image.asset(
            AssetPath.creditCardPayment,
            width: sizeImage,
            height: sizeImage,
          ),
          title: const Text(
            'Payment methods',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          onTap: () {
            print("choose payment");
          },
        ),
        ListTile(
          leading: Image.asset(
            AssetPath.history,
            width: sizeImage,
            height: sizeImage,
          ),
          title: const Text(
            'Parking History',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          onTap: () {
            print("Get history");
          },
        ),
        ListTile(
          leading: Image.asset(
            AssetPath.promotions,
            width: sizeImage,
            height: sizeImage,
          ),
          title: const Text(
            "Promotion code",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          onTap: () {
            print("get promotion code");
          },
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          leading: Image.asset(
            AssetPath.customerService,
            width: sizeImage,
            height: sizeImage,
          ),
          title: const Text(
            'Support',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          onTap: () {
            print("View support");
          },
        ),
        ListTile(
          leading: Image.asset(
            AssetPath.setting,
            width: sizeImage,
            height: sizeImage,
          ),
          title: const Text(
            'Setting',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          onTap: () {
            print("View Setting");
          },
        ),
      ],
    ));
  }
}
