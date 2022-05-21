import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/signin_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/forgot_password.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/ui/on_boarding2.dart';
import 'package:qr_code_generator/ui/sign_up.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? rememberMe = false;
  bool? _loading = false;
  bool? hidePassword = true;

  @override
  initState() {
    super.initState();
    setDataToFields();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnBoarding2()),
        );
        return true;
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  height: 140,
                  width: 140,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      // fontFamily: 'Mulish',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Sign in to Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      // fontFamily: 'Mulish',
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
                      prefixIcon: const Icon(Icons.mail),
                    ),
                  ),
                ),
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
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(
                        icon: hidePassword!
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.visibility_rounded),
                        onPressed: () {
                          hidePassword = !hidePassword!;
                          _redraw();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            fillColor:
                                MaterialStateProperty.all(QRTheme.mainColor),
                            // side: BorderSide(
                            //   style: BorderStyle.solid,
                            //   color: QRTheme.mainColor,
                            //   width: 4,
                            // ),
                            value: rememberMe,
                            onChanged: (value) {
                              rememberMe = value;
                              _redraw();
                            },
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              fontFamily: 'Mulish',
                            ),
                          ),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()));
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            fontFamily: 'Mulish',
                          ),
                        ),
                      ),
                    ],
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
                          // const SizedBox(height: 32, width: 44),
                          _loading!
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CupertinoActivityIndicator(),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21,
                                    fontFamily: 'Mulish',
                                  ),
                                ),
                          // const SizedBox(height: 24, width: 44),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (_emailController.text == '') {
                        showErrorText(context, 'Enter Email');
                        return;
                      }
                      if (_passwordController.text == '') {
                        showErrorText(context, 'Enter Password');
                        return;
                      }
                      _loading = true;
                      _redraw();
                      _signIn();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Divider(thickness: 1),
                    ),
                    const Text(
                      'or',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialButton(context, 'Google', QRTheme.googleColor, () {
                      print('Google');
                    }),
                    socialButton(context, 'Facebook', QRTheme.facebookColor, () {
                      print('Facebook');
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'Mulish',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: QRTheme.mainColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          fontFamily: 'Mulish',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  Future _signIn() async {
    final isSignedIn = await AppAPIs().signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    _loading = false;
    _redraw();
    if (isSignedIn) {

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = jsonDecode(sharedPreferences.getString('userDetails')!);

      var id = response['user']['_id'];

      Map <String,dynamic> user = {
        id : {
          "folders" : [],
        },
      };

      String folders = jsonEncode(user);

      if(sharedPreferences.getString('folders') == null){
        sharedPreferences.setString('folders', folders);
      } else {
        String? temp = sharedPreferences.getString('folders');
        Map userFolders = jsonDecode(temp!);

        if(!userFolders.containsKey(id)){
          String? temp = sharedPreferences.getString('folders');
          Map userFolders = jsonDecode(temp!);

          userFolders[id] = {
            "folders" : [],
          };

          String tempFinal = jsonEncode(userFolders);
          sharedPreferences.setString('folders', tempFinal);


        }
      }

      
        print(sharedPreferences.getString('folders'));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: QRTheme.googleColor,
          content: socialButton(
            context,
            'Login Failed',
            QRTheme.googleColor,
            () {},
          ),
        ),
      );
    }
  }

  Future setDataToFields() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('userDetails') != null) {
      var user = sp.getString('userDetails');
      SignInResponse signedInUser = SignInResponse.fromJson(jsonDecode(user!));
      _emailController.text = signedInUser.user!.email!;
    }
  }
}
