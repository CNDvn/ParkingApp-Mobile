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
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/model/entity/parking.dart';
import 'package:parkingappmobile/repository/impl/parking_rep_impl.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  List<String> addressParking = [];
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
        tmp[
            ParkingDetailValue(
                id: item.id, name: item.name, address: item.address)] = Marker(
            width: 100,
            height: 50,
            point:
                LatLng(item.coordinates.latitude, item.coordinates.longitude),
            builder: (ctx) => SizedBox(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                      item.name,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 8,
                          color: AppColor.blackText,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.local_parking_sharp, color: Colors.blue[800])
                  ]),
                )));
        list.addAll(tmp);
      }
      setState(() {
        list.forEach((key, value) {
          addressParking.add(key.address);
          markers.add(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    onTapDestination(p) {
      list.forEach((key, value) {
        if (p == key.address) {
          mapProvider.id = key.id;
          setState(() {
            LatLng tmp = LatLng(0, 0);
            tmp = LatLng(value.point.latitude, value.point.longitude);
            mapProvider.destination = tmp;
            mapProvider.addressParkingController.text = "";
            mapProvider.addressParkingController.text = key.address;
            mapProvider.checkPoint();
            Future.delayed(const Duration(milliseconds: 50), () {
              mapProvider.mapController
                  .move(mapProvider.destination, mapProvider.zoomMap);
            });
          });
          mapProvider.getJsonData();
          return;
        }
      });
    }

    if (mounted) {
      if (mapProvider.point.latitude == 0) {
        mapProvider.updatePosition();
        mapProvider.list = list;
      }
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
                  Future.delayed(const Duration(microseconds: 50), () async {
                    tmp = await Geocoder.local.findAddressesFromCoordinates(
                        Coordinates(p.latitude, p.longitude));
                  });
                  setState(() {
                    mapProvider.destination = p;
                    mapProvider.location = tmp;
                    mapProvider.clearGetAddressParking();
                    mapProvider.checkPoint();
                    Future.delayed(const Duration(milliseconds: 50), () {
                      mapProvider.mapController.move(
                          LatLng(mapProvider.destination.latitude,
                              mapProvider.destination.longitude),
                          mapProvider.zoomMap);
                    });
                    mapProvider.getJsonData();
                  });
                },
                center: mapProvider.destination,
                zoom: 16.5,
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
                MarkerLayerOptions(
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
                    Marker(
                      width: 50,
                      height: 50,
                      point: mapProvider.destination,
                      builder: (ctx) => const SizedBox(
                        child: Icon(
                          Icons.share_location_outlined,
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
                CircleLayerOptions(circles: [
                  CircleMarker(
                      point: mapProvider.destination,
                      useRadiusInMeter: true,
                      radius: 200,
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
                    child: SizedBox(
                      child: SearchField(
                        controller: mapProvider.addressParkingController,
                        hint: "Where are you going to ?",
                        searchInputDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (!addressParking.contains(
                                    mapProvider.addressParkingController.text))
                                  IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () => {
                                            setState(() {
                                              mapProvider.submitData(context);
                                            })
                                          }),
                                if (mapProvider
                                    .addressParkingController.text.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      mapProvider.clearGetAddressParking();
                                      mapProvider.polyPoints.clear();
                                      mapProvider.flag = false;
                                    },
                                  )
                              ],
                            )),
                        maxSuggestionsInViewPort: 5,
                        suggestions: addressParking,
                        itemHeight: 40,
                        onTap: onTapDestination,
                      ),
                    )),
                Card(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: mapProvider.flag
                      ? SizedBox(
                          child: ButtonDefault(
                          content: "View Parking Detail",
                          voidCallBack: () {
                            mapProvider.detailParking(context, mapProvider.id);
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
