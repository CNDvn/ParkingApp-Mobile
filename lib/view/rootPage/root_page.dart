import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/widgets/drawer/drawer.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Root Page"),
      ),
      body: Column(
        children: [Image.asset(AssetPath.posterCity)],
      ),
      drawer: const DrawerDefault(),
    );
  }
}
