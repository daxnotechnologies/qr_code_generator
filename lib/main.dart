import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/splash.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Generator',
      theme: ThemeData(
        primarySwatch: QRTheme.mainMaterialColor,
      ),
      home: const Splash(title: 'QR Code Generator'),
    );
  }
}
