import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/ui/login.dart';
import 'package:qr_code_generator/ui/on_boarding1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? isFirstTime = true;
  bool? isSignedIn = false;

  @override
  initState() {
    super.initState();
    _goNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QRTheme.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              height: 140,
              width: 140,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'QR Code Generator',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 29,
                  fontFamily: 'Mulish',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _goNext() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getBool('isSignedIn') != null) {
      isSignedIn = sp.getBool('isSignedIn');
    }
    if (sp.getBool('isFirstTime') != null) {
      isFirstTime = sp.getBool('isFirstTime');
    }
    print(' isFirstTime = $isFirstTime  isSignedIn= $isSignedIn ');
    Timer(
      const Duration(milliseconds: 700),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isSignedIn!
                ? Home()
                : (isFirstTime! ? const OnBoarding1() : const Login()),
            // isFirstTime! ? const OnBoarding1() : const Login(),
          ),
        );
      },
    );
  }
}
