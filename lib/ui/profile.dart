import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/signin_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/create_qr_code.dart';
import 'package:qr_code_generator/widgets/bottom_app_bar.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool? _loading = false;
  var date='2020-02-20';
  @override
  initState() {
    super.initState();
    setFields();
  }
 Future<String> GetData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var data=await pref.getString("userDetails");
    return data.toString();
  var jsons=json.decode(json.encode(data));
    print("oy"+jsons);
    //  User user=new User();
    //  user.email="hello";
    // // user.email=await jsons["email"].toString();
    // // user.contact=await jsons['contact'].toString();
    // // user.dob=await jsons['dob'].toString();
    // // user.sId=await jsons['_id'].toString();
    // // user.lastName=await jsons['lastName'].toString();
    // // user.firstName=await jsons['firstName'].toString();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: QRTheme.mainColor,
        label: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateQRCode(),
            ),
          );
        },
      ),
      // resizeToABottomInset: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: FutureBuilder<String>(
                future: GetData(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if(snapshot.hasData) {
                    String str=snapshot.data.toString();
                    var jsons=  json.decode(str);
                    var user= jsons['user'];

                    _emailController.text = user['email'];
                    _dobController.text = user['dob'];
                    _phoneController.text = user['contact'];
                    _nameController.text = user['firstName'] + " " + user['lastName'];
                    _addressController.text = user['address'] == null ? "" : user['address'];
                

                    return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 220,
                            decoration: BoxDecoration(
                              color: QRTheme.mainColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(64),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Transform.translate(
                                offset: const Offset(0, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          selectImage(context);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 50,
                                          child: hasPicture!
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(50),
                                                    image: DecorationImage(
                                                      image: FileImage(selectedfile!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  // child: Image.file(
                                                  //   selectedfile!,
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                )
                                              : const Icon(
                                                  Icons.photo_camera_outlined,
                                                  size: 40,
                                                  color: Colors.black54,
                                                ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Change Profile Picture',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Mulish',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: QRTheme.mainColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 276,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topRight: const Radius.circular(64),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Full Name',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: QRTheme.mainColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Mulish',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Restaurant Name
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 8.0, right: 8.0),
                                        child: TextFormField(
                                          controller: _nameController,
                                          enabled: true,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Mulish',
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: fInputDecor.copyWith(
                                            hintText:  user['lastName']??"",
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Enter Email",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: QRTheme.mainColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Mulish',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Email Address
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 8.0, right: 8.0),
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
                                          ),
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width /
                                                    2 -
                                                8,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'Date of Birth',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: QRTheme.mainColor,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Mulish',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Date of Birth
                                                InkWell(
                                                  onTap: (){
                                                    showDialog(
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
                                                                          initialDateTime: DateTime(2022, 1, 01),
                                                                          onDateTimeChanged: (value) {
                                                                            date =
                                                                                value.toString().split(' ').first;
                                                                            
                                                                            // _redraw();
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
                                                                          _dobController.text = date;
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
                                                    padding: const EdgeInsets.only(
                                                        top: 0.0,
                                                        left: 8.0,
                                                        right: 8.0),
                                                    child: TextFormField(
                                                      controller: _dobController,
                                                      enabled: false,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        fontFamily: 'Mulish',
                                                      ),
                                                      keyboardType:
                                                          TextInputType.emailAddress,
                                                      decoration: fInputDecor.copyWith(
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width /
                                                    2 -
                                                8,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'Phone Number',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: QRTheme.mainColor,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Mulish',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Phone Number
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 0.0,
                                                      left: 8.0,
                                                      right: 8.0),
                                                  child: phoneField(context)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Restaurant Name
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Address',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: QRTheme.mainColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Mulish',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 8.0, right: 8.0),
                                        child: TextFormField(
                                          controller: _addressController,
                                          enabled: true,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Mulish',
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: fInputDecor.copyWith(
                                            hintText: 'Enter Address',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: MaterialButton(
                                          minWidth: MediaQuery.of(context).size.width,
                                          // minWidth: 200,
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
                                                  'Save Changes',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 21,
                                                    fontFamily: 'Mulish',
                                                  ),
                                                ),
                                          onPressed: () async {
                                            // Navigator.pushReplacement(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => Home(),
                                            //   ),
                                            // );
                                            // var b = base64String(
                                            //     await selectedfile!.readAsBytes());
                                            // print('b is M----$b-----M');
                                            // _emailController.text = b;
                                        
                                            if (_nameController.text == '') {
                                              showErrorText(
                                                  context, 'Enter Last Name');
                                              return;
                                            }
                                            if (_dobController.text == '') {
                                              showErrorText(
                                                  context, 'Enter Date of Birth');
                                              return;
                                            }
                                            if (_phoneController.text == '') {
                                              showErrorText(
                                                  context, 'Enter Phone Number');
                                              return;
                                            }
                                            if (_emailController.text == '') {
                                              showErrorText(context, 'Enter Email');
                                              return;
                                            }
                                            
                                             print( _nameController.text.split(' ').first);
                                              print(_nameController.text.split(' ').last);

                                            _loading = true;
                                            _redraw();
                                            var res = await AppAPIs().editUser(
                                              _nameController.text.split(' ').first,
                                              _nameController.text.split(' ').last,
                                              _dobController.text,
                                              _phoneController.text,
                                              _emailController.text,
                                              user['password'],
                                              user['gender']
                                            );

                                            _loading = false;
                                            _redraw();

                                              final isSignedIn = await AppAPIs().signIn(
                                                _emailController.text.trim(),
                                                user['password']
                                              );
                                              _redraw();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  else{
                    return Container(
                      child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      ),
                    );
                  }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
  String? phone = '';
  String? phoneCode = 'AFG';

  Widget phoneField(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'AFG');
    return Container(
      child: (
          InternationalPhoneNumberInput(
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
  File? selectedfile;
  bool? hasPicture = false;
  String? buttonText = 'Upload';

  selectImage(BuildContext context) async {
    XFile? pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // var p = pickedfile!.path;
    File file = File(pickedfile!.path);
    setState(() {
      selectedfile = file;
      hasPicture = true;
    });
    // final picker = ImagePicker();
    // PickedFile pickedfile = await picker.getImage(source: ImageSource.gallery);
    // file = File(pickedfile.path);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  setFields() {
    //
  }
}
