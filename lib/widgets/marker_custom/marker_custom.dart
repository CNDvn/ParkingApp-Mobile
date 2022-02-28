import 'package:flutter/material.dart';

class MarkerCustom extends StatelessWidget {
  const MarkerCustom({Key? key, required this.title, required this.onPress})
      : super(key: key);
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: const Icon(Icons.directions_car_filled),
        tooltip: title,
        onPressed: () {
          showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const Text("test");
              });
        },
      ),
    );
  }
}
