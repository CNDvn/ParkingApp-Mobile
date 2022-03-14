import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/parking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/tracking_car_provider.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class TrackingCar extends StatefulWidget {
  const TrackingCar({Key? key}) : super(key: key);

  @override
  State<TrackingCar> createState() => _TrackingCarState();
}

class _TrackingCarState extends State<TrackingCar> {
  Duration duration = const Duration();
  String? hours;
  String? minutes;
  String? seconds;

  Timer? timer;
  String pauseTime = "";
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void addTime() {
    var addSecond = 1;
    setState(() {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  Widget buildTime(int hourbook,int minutebook,int secondbook) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      seconds = twoDigits((duration.inSeconds).remainder(60));
    hours = twoDigits(duration.inHours);
    minutes = twoDigits((duration.inMinutes).remainder(60));
    

    return Text('$hours:$minutes:$seconds', style: AppTextStyles.h1Black);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    ParkingDetailsProvider providerParking =
        Provider.of<ParkingDetailsProvider>(context);
    TrackingCarProvider providerTracking =
        Provider.of<TrackingCarProvider>(context);
    BookingDetailProvider providerBooking =
        Provider.of<BookingDetailProvider>(context);
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    String formattedTime = DateFormat('KK:mm:a').format(now);

    stopTimer() {
      var toalTime = timer?.tick;
      log(toalTime.toString());
      pauseTime = toalTime.toString();
      providerTracking.addInformation(
          formattedTime, '$hours:$minutes:$seconds');
      providerTracking.insertStorage();
      log(providerTracking.bookingTime);
      providerBooking.getInformation();
      //------------------
      providerTracking.checkOut(context);
      setState(() {
        timer?.cancel();
      });
    }

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
                child: myCarProvider.carBooked.isNotEmpty
                    ? Text(
                        providerParking.parkingName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.greyText,
                            fontSize: 28,
                            fontWeight: FontWeight.w400),
                      )
                    : SizedBox(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        child: Text(
                          "Your Cars In The Parking",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.greyText,
                              fontSize: 28,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
              ),
              SizedBox(
                child: Container(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 60),
                      child: Text("Start Time: ",
                          style: TextStyle(
                              color: AppColor.blackText, fontSize: 17)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 60),
                      child: myCarProvider.startTime.isNotEmpty
                          ? Text(myCarProvider.startTime,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))
                          : Text(formattedTime,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ]),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                    child: const Text("Choose Your Car: "),
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                    child: myCarProvider.carBooked.isNotEmpty
                        ? Text(
                            myCarProvider.carBooked,
                            style: AppTextStyles.h3black,
                          )
                        : DropdownButton(
                            value: myCarProvider.firstCarBooked,
                            onChanged: (String? newValue) {
                              setState(() {
                                myCarProvider.firstCarBooked = newValue!;
                                myCarProvider.getIdCarBooked();
                                myCarProvider.getBookingByIdCar();
                              });
                            },
                            items:
                                myCarProvider.myCarsBooked.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
              SizedBox(
                  height: size.height * 0.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(child: Lottie.asset(AssetPath.trackingCar)),
                      SizedBox(
                          height: size.height * 0.2,
                          child: Image.asset(AssetPath.car))
                    ],
                  )),
              // if (myCarProvider.carBooked.isNotEmpty)
                SizedBox(
                  height: size.height * 0.1,
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.,
                                children: [
                                  SizedBox(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: size.height * 0.01),
                                      child: const Text("Time Clock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  buildTime(myCarProvider.hoursBook,myCarProvider.minutesBook,myCarProvider.secondsBook),
                                ],
                              )
                            ]);
                      }),
                ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: ConfirmationSlider(onConfirmation: stopTimer),
                  )),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.04),
                child: GestureDetector(
                    child: Text(
                      "Go back Home",
                      style: AppTextStyles.h3black,
                    ),
                    onTap: () {
                      mapProvider.reset();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/BottomTabBar", (route) => false);
                    }),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ));
  }
}
