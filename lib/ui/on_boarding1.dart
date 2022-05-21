import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/on_boarding2.dart';
import 'package:qr_code_generator/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QRTheme.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/smartphone-scanning-qr-code.png',
              width: 250,
              height: 300,
            ),
            Transform.translate(
              offset: Offset(0, -30),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(900, 300),
                  topRight: Radius.elliptical(900, 300),
                ),
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 22),
                  color: Colors.white,
                  child: Column(
                    children: [
                      // SizedBox(width: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AllWidgets.text1('Let\'s', Colors.black),
                          ),
                          AllWidgets.text1('Generate', QRTheme.mainColor),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AllWidgets.text1('And', Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AllWidgets.text1('Scan', QRTheme.mainColor),
                          SizedBox(width: 8),
                          AllWidgets.text1('Code', Colors.black),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Eu\n viverra venenatis tempor odio.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: 'Mulish',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: MaterialButton(
                          minWidth: 200,
                          height: 80,
                          elevation: 4.0,
                          color: QRTheme.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 21,
                              fontFamily: 'Mulish',
                            ),
                          ),
                          onPressed: () {
                            goToOnBoarding2();
                            // showDialog(
                            //   context: context,
                            //   builder: (_) => Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text('data'),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future goToOnBoarding2() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isFirstTime', false);
    print('saved');
    var f = sp.getBool('isFirstTime');
    print('saved f value is $f');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnBoarding2(),
      ),
    );
  }
}
