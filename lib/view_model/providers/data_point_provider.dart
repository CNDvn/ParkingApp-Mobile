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

const String apiKey =
    '5b3ce3597851110001cf62480a3c8b8ff5eb4d889ea0af6dd8059502';

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
  final String address;

  const ParkingDetailValue({
    required this.name,
    required this.id,
    required this.address,
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

  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    String uri =
        '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat';
    http.Response response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}

class GetLocal {
  GetLocal({required this.address});
  final String address;

  String url = 'https://api.openrouteservice.org/geocode/search';

  Future getData() async {
    http.Response response =
        await http.get(Uri.parse('$url?api_key=$apiKey&text=$address&size=1'));

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
  ValidationItem _addressParking = ValidationItem(null, null);
  final _getAddressParkingController = TextEditingController();

  ValidationItem get addressParking => _addressParking;
  TextEditingController get addressParkingController =>
      _getAddressParkingController;
  String get textAddressParking => addressParkingController.text;

  final _addressParkingFocus = FocusNode();
  FocusNode get addressParkingFocus => _addressParkingFocus;
  // ignore: prefer_collection_literals
  Map<ParkingDetailValue, Marker> list = Map<ParkingDetailValue, Marker>();

  void clearGetAddressParking() {
    addressParkingController.clear();
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
    Future.delayed(const Duration(seconds: 1), () {
      polyPoints.clear();
    });

      NetworkHelper network = NetworkHelper(
      startLat: point.latitude,
      startLng: point.longitude,
      endLat: destination.latitude,
      endLng: destination.longitude,
    );

    try {
      data = null;
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

  void submitData(BuildContext context) {
    if (_getAddressParkingController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      _addressParking = ValidationItem("", null);
      _addressParking = ValidationItem(_getAddressParkingController.text, null);
      getJsonData1();
      notifyListeners();
    }
  }

  bool flag = false;
  checkPoint() {
    flag = false;
    list.forEach((key, value) {
        if (value.point == destination) {
          flag = true;
          id = key.id;
          return;
        }
      });
      notifyListeners();
  }
  
  void getJsonData1() async {
    polyPoints.clear();
    
    GetLocal local = GetLocal(address: textAddressParking);

    try {
      // ignore: prefer_typing_uninitialized_variables
      var data1;
      data1 = await local.getData();
      LineString ls_1 =
          LineString(data1['features'][0]['geometry']['coordinates']);
      destination = LatLng(ls_1.lineString[1], ls_1.lineString[0]);
      checkPoint();
      Future.delayed(const Duration(milliseconds: 50), () {
        mapController.move(destination, zoomMap);
      });
      getJsonData();
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  resetAll() async {
    mapController = MapController();
    location.clear();
    polyPoints.clear();
    clearGetAddressParking();
    // destination = LatLng(0, 0);
    updatePosition();
    flag =false;
    notifyListeners();
  }

  reset() async {
    mapController = MapController();
    notifyListeners();
  }

  Future<void> updatePosition() async {
    if (point.latitude !=0) {
      Future.delayed(const Duration(milliseconds: 50), () {
      mapController.move(point, zoomMap); 
      return;     
    });
    }
    LatLng pos = await determinePosition();
    point = pos;
    destination = pos;
    Future.delayed(const Duration(milliseconds: 50), () {
      mapController.move(point, zoomMap);
    });
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
