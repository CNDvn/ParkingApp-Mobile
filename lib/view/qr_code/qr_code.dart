import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view/viewPark/view_park.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
    UserProfileProvider userProvider =
        Provider.of<UserProfileProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerDefault(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      )),
                      SizedBox(
                        child: ClipOval(
                          child: Material(
                            color: AppColor.blueBackground,
                            child: InkWell(
                              splashColor: AppColor.whiteBackground,
                              onTap: () {
                                userProvider.getProfile();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const UserProfile();
                                }));
                              },
                              child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Image.asset(AssetPath.profilePhoto)),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
            Column(children: [
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
              FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.pauseCamera();
                              },
                              child: const Icon(Icons.not_started_outlined),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.resumeCamera();
                              },
                              child: const Icon(Icons.pause),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              )
            ]),
            SizedBox(
              child: ButtonDefault(
                  content: "Validate",
                  voidCallBack: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ViewPark();
                    }));
                  }),
            )
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
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
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