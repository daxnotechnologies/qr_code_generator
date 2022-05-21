import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/show_QR.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:qr_code_generator/widgets/item.dart';
import 'package:qr_code_generator/widgets/menu_preview_header.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';
import 'package:qr_code_generator/widgets/single_big_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMenu extends StatefulWidget {
  AddMenu({
    Key? key,
    this.resturantName,
    this.address,
    this.city,
    this.contact,
    this.name,
  }) : super(key: key);
  String? resturantName, address, city, contact, name;
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? headerImage;
  File? backgroundImage;
  bool? hasPicture = false;
  List? items = [];
  List<Items>? previewItems = [];

  bool? _loading = false;

  double? total = 0.0;
  int? index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Menu',
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        selectImage(context, 1);  
                      },
                      child: headerImage == null
                          ? singleBigButton(context, 'Upload Header Image',
                              Icons.photo_camera_back_outlined)
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.3,
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
                    InkWell(
                      onTap: () {
                        selectImage(context, 2);
                      },
                      child: backgroundImage == null
                          ? singleBigButton(context, 'Upload Background Image',
                              Icons.screen_share_outlined)
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.38,
                              decoration: BoxDecoration(
                                color: QRTheme.mainColor,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(backgroundImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Item Name',
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
              // Restaurant Name
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _itemNameController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.name,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter name',
                    prefixIcon: Icon(
                      Icons.content_paste_rounded,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Enter item name here',
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
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                    child: Text(
                      'Category',
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          side: BorderSide(color: Color(0xFF1DBF73), width: 1.5),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                          value: index == 0,
                          onChanged: (value) {
                            if (value!) {
                              index = 0;
                              _redraw();
                            }
                          },
                        ),
                        simpleText('Regon'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          side: BorderSide(color: Color(0xFF1DBF73), width: 1.5),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                          value: index == 1,
                          onChanged: (value) {
                            if (value!) {
                              index = 1;
                              _redraw();
                            }
                          },
                        ),
                        simpleText('Gulten Free'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          side: BorderSide(color: Color(0xFF1DBF73), width: 1.5),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                          value: index == 2,
                          onChanged: (value) {
                            if (value!) {
                              index = 2;
                              _redraw();
                            }
                          },
                        ),
                        simpleText('Spicy'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          side: BorderSide(color: Color(0xFF1DBF73), width: 1.5),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                          value: index == 3,
                          onChanged: (value) {
                            if (value!) {
                              index = 3;
                              _redraw();
                            }
                          },
                        ),
                        simpleText('Vegetarian'),
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                children: const [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                    // padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Per Quantity Price',
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
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _itemPriceNameController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.number,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter Price here',
                    prefixIcon: Icon(
                      Icons.perm_contact_cal_rounded,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Enter Price',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
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
                  keyboardType: TextInputType.text,
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
                  child: Row(
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
                        'Add Item',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          fontFamily: 'Mulish',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (_itemNameController.text == '') {
                      showErrorText(context, 'Enter Item Name');
                      return;
                    }
                    if (_itemPriceNameController.text == '') {
                      showErrorText(context, 'Enter Price');
                      return;
                    }
                    if (_descriptionController.text == '') {
                      showErrorText(context, 'Enter Description');
                      return;
                    }
                    // items!.clear();
                    // previewItems!.clear();
                    var id = '${items!.length + 1}' +
                        DateTime.now()
                            .toString()
                            .replaceAll('-', '')
                            .replaceAll(':', '')
                            // .replaceAll('.', '')
                            .replaceAll(' ', '')
                            .split('.')
                            .first;
                    print('$id  ${id.length}');
                    var item = Items(
                      id: int.tryParse(id),
                      name: _itemNameController.text,
                      price: _itemPriceNameController.text,
                      description: _descriptionController.text,
                    );
                    previewItems!.add(item);
                    items!.add(item.toJson());
                    print(' ${items!.length}  $items');
                    _redraw();
                    resetFields();
                    calculateTotal();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Home(),
                    //   ),
                    // );
                  },
                ),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Menu Preview',
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Material(
                  color: QRTheme.mainColor,
                  child: Column(
                    children: [
                      menuPreviewHeader(),
                      Wrap(
                        children: previewItems!.length != 0
                            ? previewItems!.map((item) {
                                return singleItem(item);
                              }).toList()
                            : [
                                rdKeyText('No Item'),
                              ],
                      ),
                      previewItems!.length != 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ffMenuHeaderText('Total'),
                                    ffMenuHeaderText('\$$total'),
                                    // ffMenuHeaderText('\$38.00'),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
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
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: _loading!
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 44.0),
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Create Menu',
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

                    
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                    var temp = sharedPreferences.getString('userDetails');
                    
                    var user = json.decode(temp!);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Bucket(),
                    //   ),
                    // );
                    // AppAPIs().createMenu(resturantName, address, city, contact, name, items, headerImg, backgroundImg)

                    if (items!.isEmpty) {
                      showErrorText(context, 'Add Items');
                      return;
                    }
                    final hImage =
                        base64String(await headerImage!.readAsBytes());
                    final bImage =
                        base64String(await headerImage!.readAsBytes());
                    _loading = true;
                    _redraw();
                    final response = await AppAPIs().createMenu(
                      widget.resturantName,
                      widget.address,
                      widget.city,
                      widget.contact,
                      widget.name,
                      items,
                      hImage,
                      bImage,
                      user['user']['_id']
                    );

                    print(response);

                    if (response['message']) {


                      var mid = response['menu']['_id'];

                      var resString = await AppAPIs().getMenu(mid);

                      saveFolder(user['user']['_id'], mid);
                      
                      _loading = false;
                      _redraw();
                      
                      showSuccessMessage(context, 'Menu Created');
                      var res = jsonDecode(resString);
                      //print(res);

                      var qrcode = res['menu']['qrcode'];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowQR(image: qrcode),
                        ),
                      );

                    } else {
                      showErrorText(context, 'Operation Failed');
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

  selectImage(BuildContext context, int i) async {
    XFile? pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedfile!.path);
    if (i == 1) headerImage = file;
    if (i == 2) backgroundImage = file;
    _redraw();
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

  resetFields() {
    _itemNameController.text = "";
    _itemPriceNameController.text = "";
    _descriptionController.text = "";
    _redraw();
  }

  calculateTotal() {
    for (var element in previewItems!) {
      total = total! + int.parse(element.price!);
    }
    _redraw();
  }

  saveFolder(uid, mid) async {
    SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString('folders');

    Map userFolders = jsonDecode(temp!);
    var userFolder = userFolders['$uid'];
    // Map userFolder = jsonDecode(tempuser);

    List folders = userFolder['folders'] == null ? [] : userFolder['folders'];

    if (folders.contains('Restaurant Folders')){
      List restaurants = userFolder['restaurant'];
      restaurants.add(mid);
      userFolder['restaurant'] = restaurants;
      userFolders['$uid'] = userFolder;
    } else {
      folders.add('Restaurant Folders');
      List restaurants = [mid];

      userFolder['restaurant'] = restaurants;
      userFolder['folders'] = folders;
      userFolders['$uid'] = userFolder;
    }

    String user = jsonEncode(userFolders);
    sharedPreferences.setString('folders', user);

    print(sharedPreferences.getString('folders'));

  }


}
