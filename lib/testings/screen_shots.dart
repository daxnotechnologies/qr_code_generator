import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_save/image_save.dart';
import 'package:screenshot/screenshot.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  Uint8List? _data;
  String? _result = '';

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_result',
              style: AppBarTheme.of(context).toolbarTextStyle,
            ),
            Screenshot(
              controller: screenshotController,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 5.0),
                  color: Colors.amberAccent,
                ),
                child: const Text("This widget will be captured as an image"),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              child: const Text('Capture Above Widget'),
              onPressed: () {
                print(' capture pressed');
                screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  print(' capture get');
                  _saveImage(capturedImage);
                  // ShowCapturedWidget(context, capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
            ElevatedButton(
              child: const Text('Capture An Invisible Widget'),
              onPressed: () {
                var container = Container(
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 5.0),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "This is an invisible widget",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
                screenshotController
                    .captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: const Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(
          child: capturedImage.isNotEmpty
              ? Image.memory(capturedImage)
              : Container(),
        ),
      ),
    );
  }

  // _saved(File image) async {
  //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
  //   print("File Saved to Gallery");
  // }

  Future<void> _saveImage(_dataImage) async {
    bool? success = false;
    try {
      success =
          await ImageSave.saveImage(_dataImage, "demo.gif", albumName: "demo");
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
    }
    setState(() {
      _result = success! ? "Save to album success" : "Save to album failed";
    });
  }
}
