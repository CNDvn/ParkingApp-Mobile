import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BookingDetailProvider providerBooking =
        Provider.of<BookingDetailProvider>(context);
    UserProfileProvider userProvider =
        Provider.of<UserProfileProvider>(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerDefault(),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      )),
                      SizedBox(
                        child: ClipOval(
                          child: Material(
                            color: AppColor.blueBackground,
                            child: InkWell(
                              splashColor: AppColor.whiteBackground,
                              onTap: () {
                                userProvider.getProfile();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const UserProfile();
                                }));
                              },
                              child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Image.asset(AssetPath.profilePhoto)),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
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
                        Text(providerBooking.parkingName,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h2Black),
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
                height: size.height * 0.4,
                width: size.width * 0.8,
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
                  margin: EdgeInsets.only(top: size.width * 0.05),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.zero,
                        child: Text(
                          "Booking Details",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.h3black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Text(
                                "Booking Time:",
                                textAlign: TextAlign.left,
                                style: AppTextStyles.h4black,
                              ),
                            ),
                            SizedBox(
                              child: Text(providerBooking.bookingTime,
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.h4black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Check-in Time:",
                                  textAlign: TextAlign.left,
                                  style: AppTextStyles.h4black,
                                ),
                              ),
                              SizedBox(
                                child: Text(providerBooking.timeCheckIn,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.h4black),
                              )
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Text(
                                "Check-out Time (Est):",
                                textAlign: TextAlign.left,
                                style: AppTextStyles.h4black,
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.timeCheckOut,
                                textAlign: TextAlign.end,
                                style: AppTextStyles.h4black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Parking Time:",
                                  textAlign: TextAlign.left,
                                  style: AppTextStyles.h4black,
                                ),
                              ),
                              SizedBox(
                                child: Text(providerBooking.parkingTime,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.h4black),
                              )
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Text(
                                "Promotion:",
                                textAlign: TextAlign.left,
                                style: AppTextStyles.h4black,
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.promotion,
                                textAlign: TextAlign.end,
                                style: AppTextStyles.h4black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Text(
                                "Total:",
                                textAlign: TextAlign.left,
                                style: AppTextStyles.h4black,
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                providerBooking.total,
                                textAlign: TextAlign.end,
                                style: AppTextStyles.h4black,
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
                margin: const EdgeInsets.only(bottom: 10),
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
