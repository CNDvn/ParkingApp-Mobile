import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/my_car/card_car.dart';

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  _MyCarState createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0, size.height * 0.05, 0, size.height * 0.05),
          ),
          const Text(
            "Your List Car",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
          ),
          SizedBox(
            height: 0.7 * size.height,
            child: ListView.builder(
              // shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const CardCar();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
