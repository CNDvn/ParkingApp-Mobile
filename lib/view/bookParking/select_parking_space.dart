import 'package:flutter/material.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class SelectParkingSpace extends StatelessWidget {
  const SelectParkingSpace({Key? key}) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool value = false;
    return Scaffold(
      drawer: const DrawerDefault(),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 20),
              height: size.height * 0.07,
              width: size.width * 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Lekki Gardens Car Park A   ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " N200",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "/Hr",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Text(
                "Select preferred space",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.greyText, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 20),
              height: 250,
              width: 342,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "5 slots Available",
                      // textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Text(
                        "Reserve spot for another time",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: AppColor.greyText, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Switch(
                        value: value,
                        onChanged: (value) {
                          // print(value);
                        },
                        activeColor: AppColor.greyBackground,
                        activeTrackColor: AppColor.greyBackground,
                        inactiveThumbColor: AppColor.whiteBackground,
                        inactiveTrackColor: AppColor.greyBackground,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.85,
                child: ButtonDefault(content: "Continue", voidCallBack: () {}))
          ],
        ),
      ),
    );
  }
}
