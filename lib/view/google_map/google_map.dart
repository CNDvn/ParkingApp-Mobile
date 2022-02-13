import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:searchfield/searchfield.dart';
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
class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  LatLng point = LatLng(10.794606, 106.721677);
  List<Address> location = [];
  MapController mapController = MapController();
  List<String> cities = [];
  LatLng? destination;
  double zoomMap = 16.0;
  @override
  void initState() {
    super.initState();
    dataPoint.forEach((value) => {cities.add(value.name)});
  }

  onTapDestination(p) {
    for (var i = 0; i < dataPoint.length; i++) {
      if (p == dataPoint[i].name) {
        setState(() {
          destination = LatLng(dataPoint[i].latitude, dataPoint[i].longitude);
          mapController.move(
            LatLng(dataPoint[i].latitude, dataPoint[i].longitude),
            zoomMap,
          );
        });
      }
    }
  }

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    // String _address = "";
    // List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      //_address = pm[0].toString();
      point = LatLng(pos.latitude, pos.longitude);
      mapController.move(LatLng(point.latitude, point.longitude), 16.0);
    });
    // var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(pos);
    // print(point);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (p) async {
                List<Address> tmp = [];
                tmp = await Geocoder.local.findAddressesFromCoordinates(
                    Coordinates(p.latitude, p.longitude));
                setState(() {
                  point = p;
                  location = tmp;
                  mapController.move(
                      LatLng(point.latitude, point.longitude), 16.0);
                });
              },
              center: point,
              zoom: 16.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 50,
                    height: 50,
                    point: point,
                    builder: (ctx) => const SizedBox(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ],
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
                  child: SearchField(
                    hint: "Where are you going to?",
                    searchInputDecoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    maxSuggestionsInViewPort: 5,
                    suggestions: cities,
                    onTap: onTapDestination,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "${location.isNotEmpty ? location.first.countryName : ""},${location.isNotEmpty ? location.first.locality : ""},${location.isNotEmpty ? location.first.featureName : ""}")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updatePosition,
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }
}
