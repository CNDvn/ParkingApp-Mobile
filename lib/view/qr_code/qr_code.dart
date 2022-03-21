import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/tracking_car_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        if (myCarProvider.firstCarBooked.isNotEmpty) {
                          myCarProvider.getMyCar();
                          myCarProvider.carBooked = "";
                          myCarProvider.resetAfterPay();
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/TrackingCar", (route) => false);
                      },
                    )),
                  ]),
                  SizedBox(
                    child: Text(
                      "Scan QR Code",
                      style: AppTextStyles.h4black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: Text(
                      "Align the QR code within the frame to scan.",
                      style: AppTextStyles.h5black,
                    ),
                  ),
                  SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.8,
                      child: _buildQrView(context)),
                ]),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              child: ButtonDefault(
                  content: "Reset Camera",
                  voidCallBack: () async {
                    await controller?.resumeCamera();
                  }),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width * 0.5;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    TrackingCarProvider providerTracking =
        Provider.of<TrackingCarProvider>(context, listen: false);
    final SecureStorage secureStorage = SecureStorage();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code!.isNotEmpty) {
          controller.pauseCamera();
          secureStorage.writeSecureData("idParking", result!.code.toString());
          Future.delayed(const Duration(seconds: 2), () {
            providerTracking.checkOut(context);
          });
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
