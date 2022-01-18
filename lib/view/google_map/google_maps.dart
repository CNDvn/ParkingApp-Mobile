import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.794893, 106.721443),
    zoom: 16.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerDefault(),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    margin: EdgeInsets.only(
                        left: 16.0, top: size.height * 0.2, right: 16.0),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Where are you going to?",
                      ),
                    ),
                  ),
                ]))
      ]),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
