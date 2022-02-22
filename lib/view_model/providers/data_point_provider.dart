import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:parkingappmobile/configs/exception/exception.dart';
import 'package:parkingappmobile/view_model/auth.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class DataPoint {
  final String name;
  final double latitude, longitude;

  const DataPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

List<DataPoint> dataPoint = [
  const DataPoint(
      name: 'Ho Chi Minh', latitude: 10.794606, longitude: 106.721677),
  const DataPoint(name: 'Ha Noi', latitude: 21.0031177, longitude: 105.8201408),
  const DataPoint(name: 'Quan 9', latitude: 10.8428791, longitude: 106.8297824),
  const DataPoint(name: 'Quan 1', latitude: 10.7756587, longitude: 106.7004238)
];

class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf6248de01881e3c1a42508851f987bff20c42';
  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(
        '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));

    log("$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}

class MapProvider with ChangeNotifier {
  final _getAddress = TextEditingController();

  TextEditingController get addressController => _getAddress;
  String get textAddress => addressController.text;

  void clearGetAddress() {
    addressController.clear();
    notifyListeners();
  }

  MapController mapController = MapController();
  var point = LatLng(0, 0);
  var destination = LatLng(0, 0);
  List<Address> location = [];
  double zoomMap = 16.0;
  //-------------------------
  final List<LatLng> polyPoints = [];
  dynamic data;
  Marker? marker;

  double startLat = 10.841088;
  double startLng = 106.809172;
  double endLat = 10.837543;
  double endLng = 106.730032;

  List<String> cities = [];
  
  // for (DataPoint value in dataPoint) {
  //     cities.add(value.name);
  //   }

  void getJsonData() async {
    polyPoints.clear();

    log("**********" + point.toString());

    NetworkHelper network = NetworkHelper(
      startLat: point.latitude,
      startLng: point.longitude,
      endLat: destination.latitude,
      endLng: destination.longitude,
    );

    try {
      data = await network.getData();
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
        log(ls.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updatePosition() async {
    LatLng pos = await determinePosition();
    point = pos;
    mapController.move(point, zoomMap);
  }

  Future<LatLng> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissons are permanently denied, we cannot request permissions');
    }
    Position pos = await Geolocator.getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }
}
