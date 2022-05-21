import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/otp_screen.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  bool? _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/lock.png',
              height: 240,
              width: 240,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Forgot password?',
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
                'Enter your email /Phone number for recevory\nyour account.',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _emailController,
                enabled: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Mulish',
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: fInputDecor.copyWith(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email/Phone number'),
              ),
            ),
            MaterialButton(
              onPressed: null,
              child: Text(
                'Try another ways',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontSize: 12,
                  fontFamily: 'Mulish',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      const SizedBox(height: 32, width: 44),
                      const Text(
                        'Reset password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      _loading!
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            )
                          : const SizedBox(height: 24, width: 44),
                    ],
                  ),
                ),
                onPressed: () async{
                  if (_emailController.text == '') {
                    _showErrorText('Enter Email');
                    return;
                  }
                  _loading = true;

                final response = await AppAPIs().forgotPassword(_emailController.text, 'test1234');

                if(response == null){
                  _showErrorText('Try Again');
                  return;
                } else {
                  
                    if(response['message']){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TypeOTP(email: _emailController.text, code: response['code']),
                      ),
                    );
                  } else {
                    _showErrorText('Invalid Email');
                    return;
                  }
                }
                


                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const TypeOTP(),
                  //   ),
                  // );
                },
              ),
            ),
          ],
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
