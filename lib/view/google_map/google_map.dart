import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  LatLng point = LatLng(10.794606, 106.721677);
  List<Address> location = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (p) async {
              List<Address> tmp = [];
              tmp = await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(p.latitude, p.longitude));

              setState(() {
                point = p;
                location = tmp;
              });
            },
            center: LatLng(10.794606, 106.721677),
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 30,
                  height: 30,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
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
    );
  }
}
