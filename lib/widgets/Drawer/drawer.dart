import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeImage = size.width * 0.08;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: IconButton(
                          icon: 
                          Image.asset(AssetPath.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                        ),
                  ],
                ),
                CircleAvatar(
                  radius: size.width * 0.1,
                  backgroundImage: const NetworkImage(AssetPath.avataMenu),
                ),
                const Text(
                  "Cam Tròn",
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 18, height: 2),
                )
              ],
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: 
            Image.asset(
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
            leading: 
            Image.asset(
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
            leading: 
            Image.asset(
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
            leading: 
            Image.asset(
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
            leading: 
            Image.asset(
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
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: 
            Image.asset(
              AssetPath.logout,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              print("logout");
            },
          )
        ],
      ),
    );
  }
}
