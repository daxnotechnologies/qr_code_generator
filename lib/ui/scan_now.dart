// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/models/qr_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/ui/restaurant_menu.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanNow extends StatefulWidget {
  const ScanNow({Key? key}) : super(key: key);

  @override
  _ScanNowState createState() => _ScanNowState();
}

class _ScanNowState extends State<ScanNow> {
  Barcode? result;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? menuString;

  bool? scanPaused = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Edit',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Mulish',
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              saveScannedQR();
            },
            child: SizedBox(
              width: 80,
              height: 20,
              child: homeMiniButton('Save', true),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // const SizedBox(height: 24, width: 24),
            // Expanded(flex: 4, child: _buildQrView(context)),
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 240,
                  width: 240,
                  child: _buildQrView(context),
                ),
              ),
            ),
            if (result != null)
              Text(
                'Barcode Type: ${describeEnum(result!.format)}  Data: ${result!.code}',
              )
            else
              const Text('Scan a code'),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Zoom IN & Out to Scan',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.w700,
            //       fontSize: 23,
            //       fontFamily: 'Mulish',
            //     ),
            //   ),
            // ),
            scanPaused!
                ? InkWell(
                    onTap: () {
                      reScan();
                    },
                    child: Column(
                      children: [
                        Icon(Icons.restart_alt_rounded),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Scan Again',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              fontFamily: 'Mulish',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(thickness: 1),
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'Mulish',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(thickness: 1),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                scanFromGallery();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Scan from Gallery',
                  style: TextStyle(
                    color: QRTheme.mainMaterialColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
            ),
            Text(
              'Scan result From Gallery is $qrcode',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Mulish',
              ),
            ),
            menuString != null
                ? Column(
                    children: [
                      Text(
                        'Scan Success',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          MenuResponse menuResponse =
                              MenuResponse.fromJson(jsonDecode(menuString!));
                          print('${menuResponse.menu!.city}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantMenu(
                                menu: menuResponse,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'View Scanned QR',
                            style: TextStyle(
                              color: QRTheme.mainMaterialColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              fontFamily: 'Mulish',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 24, width: 24),

//////////////////////////////
/*
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                  )
                else
                  const Text('Scan a code'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Text('Flash: ${snapshot.data}');
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                    'Camera facing ${describeEnum(snapshot.data!)}');
                              } else {
                                return const Text('loading');
                              }
                            },
                          )),
                    )
                  ],
                ),
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
                        child:
                            const Text('pause', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: const Text('resume',
                            style: TextStyle(fontSize: 20)),
                      ),
                    )
                  ],
                ),
              ],
            ),

*/
////////////////////////
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white, // Colors.red,
        borderRadius: 4, // 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 240, // scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      _redraw();
      print('scan result ${result!.code}\n'
          'format name  ${result!.format.formatName}\n');
      // var res = '''{
      //   "text": "https://qr-web-app.herokuapp.com/dashboard/view-menu/621a238d1b118b0016e25190"
      //   }''';
      var res = result!.code!;
      QRResponse qrResponse = QRResponse.fromJson(jsonDecode(res));
      var url = qrResponse.text;
      print('url $url');
      var urlparts = url!.split('/');
      print('urlparts $urlparts');
      var id = urlparts.last;
      print('id $id');
      controller.pauseCamera();
      scanPaused = true;
      _redraw();
      menuString = await AppAPIs().getMenu(id);
      if (menuString == null) {
        showErrorText(context, 'Scan Failed');
        return;
      } else {
        showSuccessMessage(context, 'Menu Scanned Successfully');
      }
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  saveScannedQR() async {
    if (menuString != null) {
      List<String>? scanList;
      List<String>? resturantfolder;
      SharedPreferences sp = await SharedPreferences.getInstance();
      if (sp.getStringList('scanList') != null) {
        scanList = sp.getStringList('scanList');
      } else {
        scanList = [];
      }
      scanList!.add(menuString!);
      sp.setStringList('scanList', scanList);
      if (sp.getStringList('restaurantFolder') != null) {
        scanList = sp.getStringList('restaurantFolder');
      } else {
        scanList = [];
      }
      scanList!.add(menuString!);
      sp.setStringList('restaurantFolder', scanList);
      print('scan QR saved');
      showSuccessMessage(context, 'Saved Successfully');
    }
  }

  String qrcode = 'Unknown';

  Future scanFromGallery() async {
    menuString = null;
    _redraw();
    qrViewController!.pauseCamera();
    List<Media>? res = await ImagesPicker.pick();
    if (res != null) {
      String? str = await Scan.parse(res[0].path);
      if (str != null) {
        setState(() {
          qrcode = str;
        });
        qrViewController!.pauseCamera();
        getScannedData();
      }
    }
  }

  Future getScannedData() async {
    QRResponse qrResponse = QRResponse.fromJson(jsonDecode(qrcode));
    var url = qrResponse.text;
    print('url $url');
    var urlparts = url!.split('/');
    print('urlparts $urlparts');
    var id = urlparts.last;
    print('id $id');
    scanPaused = true;
    _redraw();
    menuString = await AppAPIs().getMenu(id);
    _redraw();
    if (menuString == null) {
      showErrorText(context, 'Scan Failed');
      return;
    } else {
      showSuccessMessage(context, 'Menu Scanned Successfully');
    }
  }

  reScan() {
    menuString = null;
    _redraw();
    if (scanPaused!) {
      scanPaused = false;
      qrViewController!.resumeCamera();
      _redraw();
    }
  }
}
