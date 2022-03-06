import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
// ignore: unused_import
import 'package:geocoding/geocoding.dart';
// ignore: unused_import
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkingappmobile/model/entity/parking.dart';
import 'package:parkingappmobile/repository/impl/parking_rep_impl.dart';
import 'package:parkingappmobile/view/parkingDetail/parking_detail.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/process_circle/process_circle.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  String? id;
  List<String> cities = [];
  List<Marker> markers = [];
  // ignore: prefer_collection_literals
  Map<ParkingDetailValue, Marker> list = Map<ParkingDetailValue, Marker>();
  @override
  void initState() {
    super.initState();
    List<Parking>? listParking = [];
    ParkingImpl().getParkings(UrlApi.getAllParkings).then((value) async {
      listParking = value.result!.data;
      for (var item in listParking!) {
        // ignore: prefer_collection_literals
        Map<ParkingDetailValue, Marker> tmp = Map<ParkingDetailValue, Marker>();
        tmp[ParkingDetailValue(id: item.id, name: item.name)] = Marker(
            width: 100,
            point:
                LatLng(item.coordinates.latitude, item.coordinates.longitude),
            builder: (ctx) => SizedBox(
                  width: 100,
                  child: Icon(Icons.local_parking_sharp, color: Colors.blue[800])
                ));
        list.addAll(tmp);
      }
      setState(() {
        list.forEach((key, value) {
          cities.add(key.name);
          markers.add(value);
        });
      });
    });
    const Duration(milliseconds: 375);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    onTapDestination(p) {
      list.forEach((key, value) {
        if (p == key.name) {
          setState(() {
            id = key.id;
            LatLng tmp = LatLng(0, 0);
            tmp = LatLng(value.point.latitude, value.point.longitude);
            mapProvider.destination = tmp;
            mapProvider.addressController.text = key.name;
            mapProvider.mapController.move(tmp, mapProvider.zoomMap);
          });
        }
      });
      mapProvider.getJsonData();
    }

    if (mapProvider.point.latitude == 0) {
      mapProvider.updatePosition();
    }

    return Scaffold(
      body: markers.isEmpty ? const ProcessCircle() :
      Stack(
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
                    mapProvider.getJsonData();
                  });
                },
                center: mapProvider.point,
                zoom: 16.0,
                plugins: [
                  MarkerClusterPlugin(),
                ],
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerClusterLayerOptions(
                  markers: [
                    ...markers,
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
                  ],
                  builder: (context, markers) {
                    return CircleAvatar(
                      child: Text(markers.length.toString()),
                    );
                  },
                ),
                PolylineLayerOptions(
                  polylines: [
                    Polyline(
                        points: mapProvider.polyPoints,
                        strokeWidth: 4.0,
                        color: Colors.red),
                  ],
                ),
                CircleLayerOptions(circles: [
                  CircleMarker(
                      point: mapProvider.point,
                      useRadiusInMeter: true,
                      radius: 100,
                      color: Colors.blue.withOpacity(0.2),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blue)
                ])
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
                    hint: "What parking lot are you finding ?",
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
                  child: mapProvider.addressController.text.isNotEmpty
                      ? SizedBox(
                          child: ButtonDefault(
                          content: "View Parking Detail",
                          voidCallBack: () {
                            ParkingImpl()
                                .getParkingDetail(
                                    UrlApi.serverPath + "/parkings/$id")
                                .then((value) async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ParkingDetail(
                                  name: value.result!.name,
                                  images: value.result!.images,
                                  parkingSlots: value.result!.parkingSlots,
                                  address: value.result!.address,
                                  openTime: value.result!.openTime,
                                  closeTime: value.result!.closeTime,
                                  username:
                                      value.result!.business.user!.fullName,
                                  phoneNumber:
                                      value.result!.business.user!.phoneNumber,
                                );
                              }));
                            }).onError((error, stackTrace) {
                              log(error.toString());
                            });
                          },
                        ))
                      : Text(
                          "${mapProvider.location.isNotEmpty ? mapProvider.location.first.countryName + "," : ""}"
                          "${mapProvider.location.isNotEmpty ? mapProvider.location.first.featureName : ""}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
