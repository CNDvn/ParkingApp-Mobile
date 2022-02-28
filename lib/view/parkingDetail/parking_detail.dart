import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/carousel_slider/carousel_slider.dart';

class ParkingDetail extends StatelessWidget {
  const ParkingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.005, 0, size.height * 0.005),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(flex: 2, child: Container()),
                const Expanded(
                  flex: 6,
                  child: Text(
                    "Parking 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
            const CarouselSliderImage(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
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
              child: Container(
                height: size.height * 0.4,
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Slots:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "10 empty",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "Quan 1, Ho Chi minh city",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackText,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Open Time: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "6:00",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blackText,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Close Time: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "2:00",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blackText,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "Open",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Divider(color: AppColor.greyText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Owner:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "Dao Ba Loc",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackText,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hotline:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "0949382394",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.redToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            ButtonDefault(
              width: size.width,
              content: 'Continue',
              voidCallBack: () => {},
            )
          ],
        ),
      )),
    );
  }
}
