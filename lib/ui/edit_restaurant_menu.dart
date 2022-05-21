import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/add_menu.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/custom_snackbar.dart';
import 'package:qr_code_generator/widgets/item.dart';
import 'package:qr_code_generator/widgets/menu_preview_header.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';

class EditRestaurantMenu extends StatefulWidget {
  const EditRestaurantMenu({Key? key, this.menu}) : super(key: key);
  final MenuResponse? menu;
  @override
  _EditRestaurantMenuState createState() => _EditRestaurantMenuState();
}

class _EditRestaurantMenuState extends State<EditRestaurantMenu> {
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _restoNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Items>? previewItems = [];
  double? total = 0.0;

  bool? _loading = false;

  @override
  initState() {
    super.initState();
    setFields();
    calculateTotal();
  }

  setFields() {
    _menuNameController.text = widget.menu!.menu!.name!;
    _restoNameController.text = widget.menu!.menu!.resturantName!;
    _addressController.text = widget.menu!.menu!.address!;
    _cityController.text = widget.menu!.menu!.city!;
    _phoneController.text = widget.menu!.menu!.contact!;
    previewItems = widget.menu!.menu!.items!;
  }

  calculateTotal() {
    for (var element in previewItems!) {
      total = total! + int.parse(element.price!);
    }
    _redraw();
  }

  _redraw() {
    if (mounted) setState(() {});
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
          'Edit Restaurant Menu',
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
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Restaurant Details',
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
                  controller: _restoNameController,
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
                      Icons.restaurant,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Restaurant Name',
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
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              // City
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
                  keyboardType: TextInputType.streetAddress,
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
              // Phone
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _phoneController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter Phone ',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Phone ',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Menu Name
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: _menuNameController,
                  enabled: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: fInputDecor.copyWith(
                    hintText: 'Enter Menu Name',
                    prefixIcon: Icon(
                      Icons.menu_book_rounded,
                      color: QRTheme.mainColor,
                    ),
                    label: Text(
                      'Menu Name',
                      style: TextStyle(
                        color: QRTheme.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Row(
              //   children: const [
              //     Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text(
              //         'Add menu options',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w900,
              //           fontSize: 18,
              //           fontFamily: 'Mulish',
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
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
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Edit Menu',
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
                    Menu? menu = widget.menu!.menu;
                    menu!.resturantName = _restoNameController.text;
                    menu.address = _addressController.text;
                    menu.city = _cityController.text;
                    menu.contact = _phoneController.text;
                    menu.name = _menuNameController.text;
                    _loading = true;
                    _redraw();
                    final response = await AppAPIs().editMenu(
                      menu.resturantName,
                      menu.address,
                      menu.city,
                      menu.contact,
                      menu.name,
                      menu.items,
                      menu.headerImg,
                      menu.backgroundImg,
                      menu.sId,
                    );

                    _loading = false;
                    _redraw();
                    if (response) {
                      showSuccessMessage(context, 'Menu Created');
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
}
