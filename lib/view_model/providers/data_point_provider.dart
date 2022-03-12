import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:parkingappmobile/repository/impl/parking_rep_impl.dart';
import 'package:parkingappmobile/view/parkingDetail/parking_detail.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

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

class ParkingDetailValue {
  final String name;
  final String id;

  const ParkingDetailValue({
    required this.name,
    required this.id,
  });
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

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

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}

class MapProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
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
  double zoomMap = 16.5;
  //-------------------------
  List<LatLng> polyPoints = [];
  // ignore: prefer_typing_uninitialized_variables
  var data;
  String? id;

  void getJsonData() async {
    polyPoints.clear();

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
    notifyListeners();
  }

  resetAll() async {
    mapController = MapController();
    location.clear();
    polyPoints.clear();
    clearGetAddress();
    point = LatLng(0, 0);
    destination = LatLng(0, 0);
    notifyListeners();
  }

  reset() async {
    mapController = MapController();
    getJsonData();
    notifyListeners();
  }

  Future<void> updatePosition() async {
    LatLng pos = await determinePosition();
    point = pos;
    mapController.move(point, zoomMap);
    getJsonData();
    notifyListeners();
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
          'Location permissions are permanently denied, we cannot request permissions');
    }
    Position pos = await Geolocator.getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }

  void detailParking(BuildContext context, String? id) async {
    secureStorage.writeSecureData("idParking", id!);
    ParkingImpl()
        .getParkingDetail(UrlApi.serverPath + "/parkings/$id")
        .then((value) async {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ParkingDetail(
          name: value.result!.name,
          images: value.result!.images,
          parkingSlots: value.result!.parkingSlots,
          address: value.result!.address,
          openTime: value.result!.openTime,
          closeTime: value.result!.closeTime,
          slotFull: value.result!.slotFull,
          slotEmpty: value.result!.slotEmpty,
          priceLists: value.result!.priceLists,
          username: value.result!.business.user!.fullName,
          phoneNumber: value.result!.business.user!.phoneNumber,
        );
      }));
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
