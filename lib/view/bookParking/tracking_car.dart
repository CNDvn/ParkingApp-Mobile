import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/bookParking/count_time.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';

class TrackingCar extends StatelessWidget {
  const TrackingCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('KK:mm:a').format(now);
    return Scaffold(
        backgroundColor: AppColor.whiteBackground,
        drawer: const DrawerDefault(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 30, top: 50),
                child: Text(
                  "Safa Park 2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.greyText,
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.06),
                      child: Text("Check-in Time: ",
                          style: TextStyle(
                              color: AppColor.greyText, fontSize: 17)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.3),
                      child: Text(formattedTime,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ]),
                ),
              ),
              SizedBox(child: Image.asset(AssetPath.car)),
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: const Text("Parking Time",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.8,
                child: Container(
                  padding: EdgeInsets.only(left: size.width * 0.025),
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return CountTime();
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
