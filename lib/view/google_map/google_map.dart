import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkingappmobile/model/entity/parking.dart';
import 'package:parkingappmobile/repository/impl/parking_rep_impl.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  List<String> cities = [];
  List<DataPoint> dataPoint = [];
  @override
  void initState() {
    super.initState();
    List<Parking>? list = [];
    ParkingImpl().getParkings(UrlApi.getAllParkings).then((value) async {
      list = value.result!.data;
      for (var item in list!) {
        DataPoint dataPointt = DataPoint(
            name: item.name,
            latitude: item.coordinates.latitude,
            longitude: item.coordinates.longitude);
        dataPoint.add(dataPointt);
      }
      for (DataPoint value in dataPoint) {
        cities.add(value.name);
      }
      log(dataPoint.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    onTapDestination(p) {
      for (var i = 0; i < dataPoint.length; i++) {
        if (p == dataPoint[i].name) {
          setState(() {
            mapProvider.destination =
                LatLng(dataPoint[i].latitude, dataPoint[i].longitude);
            mapProvider.addressController.text = dataPoint[i].name;
            mapProvider.mapController.move(
              LatLng(dataPoint[i].latitude, dataPoint[i].longitude),
              mapProvider.zoomMap,
            );
          });
        }
      }
      mapProvider.getJsonData();
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Flexible(
                child: FlutterMap(
              mapController: mapProvider.mapController,
              options: MapOptions(
                onTap: (v, p) async {
                  List<Address> tmp = [];
                  tmp = await Geocoder.local.findAddressesFromCoordinates(
                      Coordinates(p.latitude, p.longitude));
                  setState(() {
                    mapProvider.point = p;
                    mapProvider.location = tmp;
                    mapProvider.mapController.move(
                        LatLng(mapProvider.point.latitude,
                            mapProvider.point.longitude),
                        mapProvider.zoomMap);
                  });
                },
                center: LatLng(mapProvider.startLat, mapProvider.startLng),
                zoom: 16.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 50,
                      height: 50,
                      point: mapProvider.point,
                      builder: (ctx) => const SizedBox(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Marker(
                      width: 50,
                      height: 50,
                      point: mapProvider.destination,
                      builder: (ctx) => const SizedBox(
                        child: Icon(
                          Icons.directions_car,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                PolylineLayerOptions(
                  polylines: [
                    Polyline(
                        points: mapProvider.polyPoints,
                        strokeWidth: 4.0,
                        color: Colors.red),
                  ],
                ),
              ],
            )),
          ]),
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
                    controller: mapProvider.addressController,
                    hint: "Where are you going to?",
                    searchInputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      suffixIcon: mapProvider.addressController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => mapProvider.clearGetAddress(),
                            )
                          : null,
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
                            "${mapProvider.location.isNotEmpty ? mapProvider.location.first.countryName : ""},${mapProvider.location.isNotEmpty ? mapProvider.location.first.featureName : ""}")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
