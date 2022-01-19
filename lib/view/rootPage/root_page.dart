import 'package:flutter/material.dart';
// import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/google_map/google_maps.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMaps(),
    );
  }
}
