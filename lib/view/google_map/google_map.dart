import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({ Key? key }) : super(key: key);

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  double long = 49.5;
  double lat = -0.09;
  LatLng point = LatLng(10.794606, 106.721677);
  List<Address> location =[];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (p) async {
              List<Address> tmp=[];
              tmp = await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(10.794606, 106.721677));
                
              setState(() {
                point = p;
                location = tmp;
              });
            },
            center: LatLng(10.794606, 106.721677),
            zoom: 10.0,
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
                  builder: (ctx) =>const SizedBox(
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
          padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Card(
                child: TextField(
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
                      Text("${location.isNotEmpty ? location.first.countryName: ""},${location.isNotEmpty? location.first.locality: ""},${location.isNotEmpty ? location.first.featureName: ""}")
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