import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets.dart';

import '../apis/apis.dart';

class ResetPasswword extends StatefulWidget {
  ResetPasswword({Key? key, required this.email}) : super(key: key);

  String email;

  @override
  _ResetPasswwordState createState() => _ResetPasswwordState();
}

class _ResetPasswwordState extends State<ResetPasswword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  bool? _loading = false;

  bool? hidePassword = true;
  bool? hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                AllWidgets.text2('New', QRTheme.mainColor),
                SizedBox(width: 8),
                AllWidgets.text2('Password', Colors.black),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Reset your password to recovery & '
                    '\nlogin to your account.',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: TextFormField(
                controller: _passwordController,
                enabled: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Mulish',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword!,
                // obscuringCharacter: '*',
                decoration: fInputDecor.copyWith(
                  hintText: 'New password',
                  prefixIcon: const Icon(Icons.lock_rounded),
                  suffixIcon: IconButton(
                    icon: hidePassword!
                        ? Icon(Icons.visibility_off_rounded)
                        : Icon(Icons.visibility_rounded),
                    onPressed: () {
                      hidePassword = !hidePassword!;
                      _redraw();
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: TextFormField(
                controller: _retypePasswordController,
                enabled: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Mulish',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: hideConfirmPassword!,
                // obscuringCharacter: '*',
                decoration: fInputDecor.copyWith(
                  hintText: 'Retype Password',
                  prefixIcon: const Icon(Icons.lock_rounded),
                  suffixIcon: IconButton(
                    icon: hideConfirmPassword!
                        ? Icon(Icons.visibility_off_rounded)
                        : Icon(Icons.visibility_rounded),
                    onPressed: () {
                      hideConfirmPassword = !hideConfirmPassword!;
                      _redraw();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                        'Confirm',
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
                          : const SizedBox(height: 24, width: 44),
                    ],
                  ),
                ),
                onPressed: () async {
                  if (_passwordController.text == '') {
                    _showErrorText('Enter Password');
                    return;
                  }
                  if (_retypePasswordController.text == '') {
                    _showErrorText('Enter Password Again');
                    return;
                  }

                  _loading = true;

                  final response = await AppAPIs().reset(widget.email, _passwordController.text);

                  if(response){
                    Navigator.pop(context);
                  } else {
                    _showErrorText('Try Again');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _redraw() {
    if (mounted) setState(() {});
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
