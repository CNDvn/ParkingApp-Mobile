import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/tracking_car_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BookingDetailProvider providerBooking =
        Provider.of<BookingDetailProvider>(context);
    MyCarProvider providerCar = Provider.of<MyCarProvider>(context);
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    TrackingCarProvider providerTracking =
        Provider.of<TrackingCarProvider>(context);
    String formattedTime = DateFormat('KK:mm:a').format(DateTime.now());    
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: size.height,
      margin:
          EdgeInsets.fromLTRB(0, size.height * 0.005, 0, size.height * 0.005),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                child: Text(
                  "PAYMENT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.greyText,
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Text(
                        "Your Name: ",
                        textAlign: TextAlign.left,
                        style: AppTextStyles.h4black,
                      ),
                    ),
                    SizedBox(
                      child: Text(providerBooking.fullName,
                          textAlign: TextAlign.end,
                          style: AppTextStyles.h4black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
                child: const Text("Your Check-out Code"),
              ),
              QrImage(
                data: providerTracking.id,
                version: QrVersions.auto,
                size: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "N°Plate:  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.blackText, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  if (providerCar.firstCarBooked.isNotEmpty)
                  SizedBox(
                    child: Text(providerCar.firstCarBooked,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.blackText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                  if (providerCar.carBooked.isNotEmpty)
                  SizedBox(
                    child: Text(providerCar.carBooked,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.blackText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
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
                  height: size.height * 0.3,
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Parking: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              width: size.width * 0.58,
                              child: Text(
                                providerBooking.parkingName,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              width: size.width * 0.58,
                              child: Text(
                                providerBooking.address,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              width: size.width * 0.58,
                              child: Text(
                                providerBooking.phoneNumber,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start Time: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.startTime,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-in Time: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.checkInTime,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-out Time: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              child: Text(
                                formattedTime,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.price,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.blueText),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.amount,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              providerBooking.flag
                  ? SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.85,
                      child: ButtonDefault(
                          content: "Go Back Home",
                          voidCallBack: () {
                            mapProvider.resetAll();
                            Navigator.pushReplacementNamed(
                                context, "/BottomTabBar");
                            providerBooking.flag = false;
                          }))
                  : SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.85,
                      child: ButtonDefault(
                          content: "Payment",
                          voidCallBack: () {
                            providerBooking.showDiaLog(context);
                          })),
            ]),
      ),
    )));
  }
}
