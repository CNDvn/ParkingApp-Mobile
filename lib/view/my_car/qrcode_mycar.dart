import 'package:flutter/material.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeMyCar extends StatefulWidget {
  const QRCodeMyCar({Key? key}) : super(key: key);

  @override
  State<QRCodeMyCar> createState() => _QRCodeMyCarState();
}

class _QRCodeMyCarState extends State<QRCodeMyCar> {
  @override
  Widget build(BuildContext context) {
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    mapProvider.reset();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/BottomTabBar", (route) => false);
                  },
                )),
              ]),
              Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  const Expanded(
                    flex: 6,
                    child: Text(
                      "QR Code - Your Car",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
              Row(children: [
                const SizedBox(
                  child: Text("Your Car(N°Plate): "),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.09,
                  child: DropdownButton(
                    value: myCarProvider.firstCar,
                    onChanged: (String? newValue) {
                      setState(() {
                        myCarProvider.firstCar = newValue!;
                        myCarProvider.getIdCar();
                      });
                    },
                    items: myCarProvider.cars.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ]),
              myCarProvider.key == ""
                  ? const Text("choose")
                  : SizedBox(
                      child: QrImage(
                        data: myCarProvider.key,
                        version: QrVersions.auto,
                        size: 120,
                      ),
                    )
            ]),
      ),
    );
  }
}
