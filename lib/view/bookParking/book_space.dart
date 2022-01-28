import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class BookSpace extends StatelessWidget {
  BookSpace({Key? key}) : super(key: key);
  double value = 1;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                "Space 4c",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.blueText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 50),
              height: 300,
              width: 342,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Estimate Duration",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Slider(
                    value: value,
                    max: 24,
                    label: value.round().toString() + "hours" + " - N1200 ",
                    onChanged: (double value) {},
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 100),
                        child: SizedBox(
                          child: Text(
                            "Check-in Time:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColor.greyText, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Image.asset("assets/images/bookmark.png",
                            fit: BoxFit.contain),
                      ),
                      SizedBox(
                        child: Text(
                          "   11:00 am",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.greyText),
                        ),
                      )
                    ],
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(top: size.height * 0.05, bottom: 10),
                      height: 1,
                      color: Colors.grey),
                  SizedBox(
                      child: Text(
                    "Specifications",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.greyText,
                        fontSize: 15),
                  )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            child: Image.asset(
                                "assets/images/el-wheelchair.png",
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(
                            child: Text(
                          "  Disabled Parking",
                          style:
                              TextStyle(color: AppColor.greyText, fontSize: 15),
                        )),
                        Container(
                          margin: const EdgeInsets.only(left: 75),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Switch(
                              value: val,
                              onChanged: (val) {
                                // print(value);
                              },
                              activeColor: AppColor.greyBackground,
                              activeTrackColor: AppColor.greyBackground,
                              inactiveThumbColor: AppColor.whiteBackground,
                              inactiveTrackColor: AppColor.greyBackground,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 6),
                          child: SizedBox(
                            child: Image.asset(
                                "assets/images/ic-round-security.png",
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(
                            child: Text(
                          "  Request Special Guard (\$10)",
                          style:
                              TextStyle(color: AppColor.greyText, fontSize: 15),
                        )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Switch(
                            value: val,
                            onChanged: (val) {
                              // print(value);
                            },
                            activeColor: AppColor.greyBackground,
                            activeTrackColor: AppColor.greyBackground,
                            inactiveThumbColor: AppColor.whiteBackground,
                            inactiveTrackColor: AppColor.greyBackground,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.85,
                child:
                    ButtonDefault(content: "Book Space", voidCallBack: () {})),
          ],
        ),
      ),
    );
  }
}
