import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qr_code_generator/ui/login.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/custom_field.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';

import 'on_boarding2.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool? _loading = false;
  String? gender;
  bool? hideConfirmPassword = true;
  bool? hidePassword = true;

  String? date = '2000-01-01';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Male", style: itemStyle), value: "MALE"),
      DropdownMenuItem(
          child: Text("Female", style: itemStyle), value: "FEMALE"),
    ];
    return menuItems;
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
                Image.asset('assets/logo.png', height: 100, width: 100),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sign Up',
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
                    'Create a new account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
                // SizedBox(height: 24),
                // First Name
                simpleField(_firstNameController, 'First Name',
                    Icons.person_outline_rounded),
                // Last Name
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: TextFormField(
                    controller: _lastNameController,
                    enabled: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Mulish',
                    ),
                    decoration: fInputDecor.copyWith(
                      hintText: 'Last Name',
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                  ),
                ),
    
                // Gender
                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                //   child: TextFormField(
                //     controller: _genderController,
                //     enabled: true,
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       fontFamily: 'Mulish',
                //     ),
                //     decoration: fInputDecor.copyWith(
                //       hintText: 'Gender',
                //       prefixIcon: const Icon(Icons.circle_outlined),
                //     ),
                //   ),
                // ),
                // Gender
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.grey[200],
                    //   borderRadius: BorderRadius.circular(15),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       blurRadius: 10,
                    //       spreadRadius: 7,
                    //       offset: const Offset(1, 1),
                    //       color: Colors.grey.withOpacity(0.2),
                    //     ),
                    //   ],
                    // ),
                    child: DropdownButtonFormField(
                      items: dropdownItems,
                      onChanged: (value) {
                        gender = value.toString().toUpperCase();
                        _genderController.text = gender!;
                        _redraw();
                      },
                      iconSize: 24,
                      iconEnabledColor: QRTheme.mainColor,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Mulish',
                      ),
                      decoration: fInputDecor.copyWith(
                        hintText: 'Gender',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Mulish',
                        ),
                        prefixIcon: const Icon(Icons.circle_outlined),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15),
                        //   borderSide: const BorderSide(color: Colors.white),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15),
                        //   borderSide: const BorderSide(
                        //     color: Colors.white,
                        //     width: 1,
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                      ),
                    ),
                  ),
                ),
    
                // Date of Birth
                InkWell(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Material(
                                elevation: 12,
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 320,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 250,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: DateTime(1947, 8, 14),
                                          onDateTimeChanged: (value) {
                                            print('$value');
                                            // _dobController.text
                                            date =
                                                value.toString().split(' ').first;
                                            _redraw();
                                          },
                                        ),
                                      ),
                                      MaterialButton(
                                        minWidth:
                                            MediaQuery.of(context).size.width / 2,
                                        height: 50,
                                        elevation: 4.0,
                                        color: QRTheme.mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        onPressed: () {
                                          _dobController.text = date!;
                                          _redraw();
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 21,
                                            fontFamily: 'Mulish',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                    child: TextFormField(
                      controller: _dobController,
                      enabled: false,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Mulish',
                      ),
                      decoration: fInputDecor.copyWith(
                        hintText: 'Date of Birth',
                        prefixIcon: const Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  ),
                ),
                // Email Address
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                      hintText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_rounded),
                    ),
                  ),
                ),
                // ////
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Container(
                    decoration: myBoxDecoration,
                    child: phoneField(context),
                  ),
                ),
                // ////
                // Phone Number
                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                //   child: TextFormField(
                //     controller: _phoneController,
                //     enabled: true,
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       fontFamily: 'Mulish',
                //     ),
                //     keyboardType: TextInputType.phone,
                //     decoration: fInputDecor.copyWith(
                //       hintText: 'Phone Number',
                //       prefixIcon: Icon(Icons.phone_outlined),
                //     ),
                //   ),
                // ),
                //  Password
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
    
                // Confirm Password
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
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
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(
                        icon: hideConfirmPassword!
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.visibility_rounded),
                        onPressed: () {
                          hideConfirmPassword = !hideConfirmPassword!;
                          _redraw();
                        },
                      ),
                    ),
                  ),
                ),
                // SignUp
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 60,
                    elevation: 4.0,
                    color: QRTheme.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _loading!
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CupertinoActivityIndicator(),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 21,
                              fontFamily: 'Mulish',
                            ),
                          ),
                    onPressed: () async {
                      if (_firstNameController.text == '') {
                        showErrorText(context, 'Enter First Name');
                        return;
                      }
                      if (_lastNameController.text == '') {
                        showErrorText(context, 'Enter Last Name');
                        return;
                      }
                      if (_dobController.text == '') {
                        showErrorText(context, 'Enter Date of Birth');
                        return;
                      }
                      if (_genderController.text == '') {
                        showErrorText(context, 'Enter Gender');
                        return;
                      }
                      if (_phoneController.text == '') {
                        showErrorText(context, 'Enter Phone Number');
                        return;
                      }
                      if (_emailController.text == '') {
                        showErrorText(context, 'Enter Email');
                        return;
                      }
                      if (_passwordController.text == '') {
                        showErrorText(context, 'Enter Password');
                        return;
                      }
                      if (_confirmPasswordController.text == '') {
                        showErrorText(context, 'Enter Password Again');
                        return;
                      }
                      _loading = true;
                      _redraw();
                      await _signUp();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Login(),
                      //   ),
                      // );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an Account?',
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
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
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
                const SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _signUp() async {
    final response = await AppAPIs().signUp(context,
      _firstNameController.text,
      _lastNameController.text,
      _emailController.text,
      _passwordController.text,
      _genderController.text,
      _dobController.text,
      phone,
      // _phoneController.text,
    );
    _loading = false;
    _redraw();
    if (response) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(), // const Home(),
        ),
        (route) => false,
      );
    }
    // return response;
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  PhoneNumber number = PhoneNumber(isoCode: 'AFG');
  String? phone = '';
  String? phoneCode = 'AFG';

  Widget phoneField(BuildContext context) {
    return Container(
      child: (InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber pNumber) {
          phoneCode = pNumber.dialCode!;
          phone = pNumber.toString();
          // _phoneController.text = pNumber.toString();
          //.phoneNumber!.split(pNumber.dialCode.toString())[1];
          print('phone : $phone');
          print('_phoneController : ${_phoneController.text}');
          print('pNumber : ${pNumber.toString()}');
        },
        onInputValidated: (bool value) {},
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          setSelectorButtonAsPrefixIcon: true,
          useEmoji: true,
          leadingPadding: 1,
          showFlags: false,
        ),
        ignoreBlank: false,
        spaceBetweenSelectorAndTextField: 2,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          fontFamily: 'Mulish',
        ),
        initialValue: number,
        textFieldController: _phoneController,
        formatInput: true,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputDecoration: fInputDecor.copyWith(
          hintText: 'Phone Number',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Mulish',
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      )),
    );
  }
}
