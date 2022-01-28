import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

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
                    top: 30, left: 30, right: 30, bottom: 20),
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
                      children: <Widget>[
                        const Text(
                          "Lekki Gardens Car Park A   ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " Space 4c",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blueText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QrImage(
                data: "1234567890",
                version: QrVersions.auto,
                size: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "Unique ID: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.blackText, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    child: Text("CPA-0129",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.blackText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 20),
                height: 200,
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
                  margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Booking Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 50),
                              child: Text(
                                "Check-in Time:",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.greyText),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 50),
                              child: Text(
                                "11:00 am",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 48),
                              child: Text(
                                "Check-out Time (Est):",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.greyText),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                "05:00 pm",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 50),
                              child: Text(
                                "Specifications",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.greyText),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Text(
                                "None",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        "Don’t know the route? ",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: AppColor.greyText, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        "Get Directions ",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: AppColor.blueText, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.85,
                  child: ButtonDefault(
                      content: "Go Back to Home Screen", voidCallBack: () {}))
            ])));
  }
}
