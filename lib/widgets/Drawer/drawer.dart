import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/sign_in_provider.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:provider/provider.dart';

class DrawerDefault extends StatefulWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  State<DrawerDefault> createState() => _DrawerDefaultState();
}

class _DrawerDefaultState extends State<DrawerDefault> {
  List<String>? notifications = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeImage = size.width * 0.1;
    SignInProvider signInProvider = Provider.of<SignInProvider>(context);
    UserProfileProvider userProvider =
        Provider.of<UserProfileProvider>(context);
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    return Drawer(
      backgroundColor: AppColor.whiteBackground,
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
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ],
                ),
                CircleAvatar(
                  radius: size.width * 0.1,
                  child: userProvider.avatarSto != null
                      ? Image.network(userProvider.avatarSto!)
                      : Image.asset(AssetPath.defaultAvatar),
                  backgroundColor: AppColor.whiteBackground,
                ),
                TextButton(
                  child: Text(
                      userProvider.fullNameSto != null
                          ? userProvider.fullNameSto!
                          : "Parking App",
                      style: AppTextStyles.h2Black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    );
                  },
                )
              ],
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.changePassword,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Change Password',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/EnterChangePassword");
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.carBookingTime,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Tracking Car',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () async {
              setState(() {
                myCarProvider.getMyCar();
                myCarProvider.carBooked="";
                myCarProvider.resetAfterPay();
                if (myCarProvider.listMyCarNoActive.isNotEmpty) {
                  Navigator.pushReplacementNamed(context, "/TrackingCar");
                } else {
                  showToastFail("No cars have been booked!!");
                }
              });
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.promotion,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              "Promotion code",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/Promotion");
            },
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.qscanCode,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'QR Code',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              if (myCarProvider.listMyCar.isNotEmpty) {
                myCarProvider.getIdCar();
                Navigator.pushReplacementNamed(context, "/QRCodeMyCar");
              }
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.settings,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Setting',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {},
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.logout,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              signInProvider.confirmSignOut(context);
            },
          ),
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.9,
            child: Image.asset(AssetPath.logoPath),
          ),
        ],
      ),
    );
  }
}
