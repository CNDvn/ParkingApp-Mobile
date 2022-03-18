import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
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
  void initState() {
    MyCarProvider myCarProvider =
        Provider.of<MyCarProvider>(context, listen: false);
    super.initState();
    myCarProvider.getMyCar();
    myCarProvider.firstCar = myCarProvider.listMyCar.keys.first;
  }
  
  @override
  Widget build(BuildContext context) {
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          margin: EdgeInsets.fromLTRB(
              0, size.height * 0.005, 0, size.height * 0.005),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                  SizedBox(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    child: Image.asset(AssetPath.logoPath),
                  ),
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        items: myCarProvider.listMyCar.keys.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    child: QrImage(
                      data: myCarProvider.key,
                      version: QrVersions.auto,
                      size: size.height * 0.4,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const SizedBox(
                    child: Text(
                        "Please use this QR-Code to check-in at the Parking Counter",
                        textAlign: TextAlign.center),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
