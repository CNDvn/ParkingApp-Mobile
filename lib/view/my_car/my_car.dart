import 'package:flutter/material.dart';

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  _MyCarState createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'My car',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
