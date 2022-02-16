import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class DataPoint {
  final String name;
  final double latitude, longitude;

  const DataPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

List<DataPoint> dataPoint = [
  const DataPoint(
      name: 'Ho Chi Minh', latitude: 10.794606, longitude: 106.721677),
  const DataPoint(name: 'Ha Noi', latitude: 21.0031177, longitude: 105.8201408),
  const DataPoint(name: 'Quan 9', latitude: 10.8428791, longitude: 106.8297824),
  const DataPoint(name: 'Quan 1', latitude: 10.7756587, longitude: 106.7004238)
];


class MapProvider with ChangeNotifier {
  MapController mapController = MapController();
  LatLng point = LatLng(10.794606, 106.721677);
  LatLng? destination;
  List<Address> location = [];
  double zoomMap = 16.0;
  
  Future<void> updatePosition() async {
    Position pos = await _determinePosition();
      point = LatLng(pos.latitude, pos.longitude);
      mapController.move(LatLng(point.latitude, point.longitude), zoomMap);
  }

  Future<Position> _determinePosition() async {
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
    return await Geolocator.getCurrentPosition();
  }
}
