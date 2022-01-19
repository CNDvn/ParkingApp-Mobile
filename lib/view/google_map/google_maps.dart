import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingappmobile/view/google_map/localtion_service.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.794893, 106.721443),
    zoom: 16.4746,
  );
  
  static const Marker _kGooglePlexMarker = Marker(
  markerId: MarkerId("_kGooglePlex"),
  infoWindow: InfoWindow(title: "Google Plex"),
  icon: BitmapDescriptor.defaultMarker,
  position: LatLng(10.794893, 106.721443));

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kLakeMarker = Marker(
  markerId:const MarkerId("_kGooglePlex1"),
  infoWindow:const InfoWindow(title: "Google Plex1"),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  position:const LatLng(10.796201, 106.720521));

  static const Polyline _kPolyline = Polyline(
    polylineId: PolylineId("_kPolyline"),
    points: [
      LatLng(10.794893, 106.721443),
      LatLng(10.796201, 106.720521)
    ],
    width: 5,
  );

  static const Polygon _kPolygon = Polygon(
    polygonId: PolygonId("_kPolyline"),
    points: [
      LatLng(10.794893, 106.721443),
      LatLng(10.796201, 106.720521),
      LatLng(10.796604, 106.721610),
      LatLng(10.795961, 106.723029),
    ],
    strokeWidth: 5,
    fillColor: Colors.transparent
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration:const InputDecoration(hintText: "Search by City"),
                onChanged: (value){
                  print(value);
                },
              )),
              IconButton(onPressed: (){
                LocaltionService().getPlaceId(_searchController.text);
              }, icon:const Icon(Icons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
            mapType: MapType.hybrid,
            markers: {
              _kGooglePlexMarker,_kLakeMarker
            },
            polylines: {
              _kPolyline
            },
            polygons: {
              _kPolygon
            },
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
                  ),
          ),]
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label:const Text('To the lake!'),
      //   icon:const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));    
  }
}