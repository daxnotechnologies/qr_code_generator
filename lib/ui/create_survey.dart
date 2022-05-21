import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/all_surveys.dart';
import 'package:qr_code_generator/models/signin_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';
import 'package:qr_code_generator/widgets/single_big_button.dart';
import 'package:qr_code_generator/widgets/survey_header.dart';
import 'package:qr_code_generator/widgets/survey_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String? image =
//     "https://lh3.googleusercontent.com/a-/AOh14GjEvLkj-QYx0Ecjhpxi7UDVyrybCk3hRxpkI4JU=s64";

class CreateSurvey extends StatefulWidget {
  const CreateSurvey({Key? key}) : super(key: key);

  @override
  _CreateSurveyState createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> {
  final TextEditingController _surveyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? surveyImage;

  bool? _loading = false;

  @override
  initState() {
    super.initState();
    getUserSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create Survey',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            fontFamily: 'Mulish',
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    selectImage(context);
                  },
                  child: headerImage == null
                      ? singleBigButton(context, 'Upload Survey Image',
                          Icons.photo_camera_back_outlined)
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.38,
                          decoration: BoxDecoration(
                            color: QRTheme.mainColor,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(headerImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),

              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Survey Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
                ],
              ),
              // Survey Name
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _surveyNameController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter Name',
                    prefixIcon: Icon(
                      Icons.content_paste_rounded,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Survey Name',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Address
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    prefixIcon: Icon(
                      Icons.perm_contact_cal_rounded,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Address',
                      style: TextStyle(color: QRTheme.mainColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _cityController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter City',
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'City',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Description
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _descriptionController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 6,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter Description here',
                    prefixIcon: Icon(
                      Icons.description_rounded,
                      color: QRTheme.mainColor,
                    ),
                    // alignLabelWithHint: true,
                    label: Text(
                      'Description',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                children: const [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      'Survey',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: QRTheme.mainColor,
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      surveyHeader(),
                      allSurveys == null
                          ? rdKeyText('No survey found')
                          : Wrap(
                              children: allSurveys!.surveys!.map((e) {
                                return Container(
                                  child: surveyItem(e),
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Thanks For Voting',
                  style: TextStyle(
                    color: QRTheme.mainColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 66,
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
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cloud_upload_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Submit Survey',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                fontFamily: 'Mulish',
                              ),
                            ),
                          ],
                        ),
                  onPressed: () async {
                    if (_surveyNameController.text == '') {
                      showErrorText(context, 'Enter Survey Name');
                      return;
                    }
                    if (_addressController.text == '') {
                      showErrorText(context, 'Enter Address');
                      return;
                    }
                    if (_cityController.text == '') {
                      showErrorText(context, 'Enter City Name');
                      return;
                    }
                    if (_descriptionController.text == '') {
                      showErrorText(context, 'Enter Description');
                      return;
                    }
                    _loading = true;
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    var res = sp.getString('userDetails');
                    SignInResponse signInResponse =
                        SignInResponse.fromJson(jsonDecode(res!));
                    var user = signInResponse.user!.sId;
                    final hImage =
                        base64String(await headerImage!.readAsBytes());

                    final response = await AppAPIs().createSurvey(
                        _surveyNameController.text,
                        _addressController.text,
                        _cityController.text,
                        _descriptionController.text,
                        hImage, // surveyImage,
                        user);
                    _loading = false;
                    _redraw();
                    if (response) {
                      showSuccessMessage(context, 'Survey Created');
                      clearFields();
                    } else {
                      showErrorText(context, 'Operation Failed');
                    }
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CreateQRCode(),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  AllSurveys? allSurveys;
  Future getUserSurveys() async {
    var response = await AppAPIs().getUserSurveys();
    if (response != null) {
      allSurveys = AllSurveys.fromJson(jsonDecode(response));
      _redraw();
    }
  }

  clearFields() {
    _surveyNameController.text = '';
    _addressController.text = '';
    _cityController.text = '';
    _descriptionController.text = '';
    headerImage = null;
  }

  File? headerImage;

  selectImage(BuildContext context) async {
    XFile? pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedfile!.path);
    headerImage = file;
    _redraw();
  }
}
