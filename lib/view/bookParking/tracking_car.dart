import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/bottom_tab_bar.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
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

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    hours = twoDigits(duration.inHours);
    minutes = twoDigits(duration.inMinutes.remainder(60));
    seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text('$hours:$minutes:$seconds', style: AppTextStyles.h1Black);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('KK:mm:a').format(now);
    ParkingDetailsProvider providerParking =
        Provider.of<ParkingDetailsProvider>(context);
    TrackingCarProvider providerTracking =
        Provider.of<TrackingCarProvider>(context);
    BookingDetailProvider providerBooking =
        Provider.of<BookingDetailProvider>(context);

    stopTimer() {
      setState(() {
        timer?.cancel();
      });
      var toalTime = timer?.tick;
      log(toalTime.toString());
      pauseTime = toalTime.toString();
      providerTracking.addInformation(
          formattedTime, '$hours:$minutes:$seconds');
      providerTracking.insertStorage();
      log(providerTracking.bookingTime);
      providerBooking.getInformation();
      Navigator.pushReplacementNamed(context, "/BookingDetails");
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
                child: Text(
                  providerParking.parkingName,
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
                      margin: const EdgeInsets.only(left: 40, right: 60),
                      child: Text("Booking Time: ",
                          style: TextStyle(
                              color: AppColor.greyText, fontSize: 17)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 60),
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
                        return Scaffold(
                            backgroundColor: AppColor.whiteBackground,
                            body: SingleChildScrollView(
                                child: Column(
                              children: [
                                buildTime(),
                                Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      width: size.width * 0.8,
                                      child: ConfirmationSlider(
                                          onConfirmation: stopTimer),
                                    )),
                                GestureDetector(
                                    child: Text(
                                      "Go back Home",
                                      style: AppTextStyles.h4black,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const BottomTabBar();
                                      }));
                                    }),
                              ],
                            )));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
