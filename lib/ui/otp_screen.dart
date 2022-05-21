import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
// import 'package:pinput/pin_put/pin_put.dart';

import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/forgot_password.dart';
import 'package:qr_code_generator/ui/reset_password.dart';
import 'package:qr_code_generator/widgets.dart';

class TypeOTP extends StatefulWidget {
  TypeOTP({Key? key, required this.email, required this.code}) : super(key: key);

  String email;
  int code;

  @override
  _TypeOTPState createState() => _TypeOTPState();
}

class _TypeOTPState extends State<TypeOTP> {
  bool? _loading = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(10.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/email.png',
                height: 240,
                width: 240,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Verify your Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please check your email box to take 4 digit\ncode for continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Pinput(
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  pinAnimationType: PinAnimationType.slide,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
              //   child: Pinput(
              //     fieldsCount: 4,
              //     textStyle: const TextStyle(
              //       fontSize: 25.0,
              //       color: Colors.black26,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     // obscureText: '*',
              //     eachFieldWidth: 50.0,
              //     eachFieldHeight: 55.0,
              //     focusNode: _pinPutFocusNode,
              //     controller: _pinPutController,
              //     submittedFieldDecoration: pinPutDecoration,
              //     selectedFieldDecoration: pinPutDecoration,
              //     followingFieldDecoration: pinPutDecoration,
              //     pinAnimationType: PinAnimationType.slide,
              //     onSubmit: (pin) {},
              //   ),
              // ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  );
                },
                child: const Text(
                  'Resend code',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // fontSize: 12,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  // minWidth: 200,
                  height: 60,
                  elevation: 4.0,
                  color: QRTheme.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32, width: 40),
                        const Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 21,
                            fontFamily: 'Mulish',
                          ),
                        ),
                        _loading!
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CupertinoActivityIndicator(),
                              )
                            : const SizedBox(height: 24, width: 40),
                      ],
                    ),
                  ),
                  onPressed: () {
                    if (_pinPutController.text == '') {
                      _showErrorText('Enter OTP');
                      return;
                    }
                    _loading = true;

                    if(widget.code == int.parse(_pinPutController.text)){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswword(email : widget.email),
                        ),
                      );
                    } else {
                      _showErrorText('Invalid Code');
                    }

                   
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showErrorText(text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: socialButton(
          context,
          '$text',
          QRTheme.googleColor,
          () {},
        ),
      ),
    );
  }
}
