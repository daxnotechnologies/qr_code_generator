import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/add_menu.dart';
import 'package:qr_code_generator/utils.dart';

class AddRestaurantMenu extends StatefulWidget {
  const AddRestaurantMenu({Key? key}) : super(key: key);

  @override
  _AddRestaurantMenuState createState() => _AddRestaurantMenuState();
}

class _AddRestaurantMenuState extends State<AddRestaurantMenu> {
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _restoNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  initState() {
    super.initState();
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
          'Restaurant Menu',
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

              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add menu options',
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
                        'Upload Menu Items',
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
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Home(),
                    //   ),
                    // );
                    // showErrorText(context, 'Select Some');
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Create Menu Items',
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
                    // if (_restoNameController.text == '') {
                    //   showErrorText(context, 'Enter Restuarant Name');
                    //   return;
                    // }
                    // if (_addressController.text == '') {
                    //   showErrorText(context, 'Enter Address');
                    //   return;
                    // }
                    // if (_cityController.text == '') {
                    //   showErrorText(context, 'Enter City Name');
                    //   return;
                    // }
                    // if (_phoneController.text == '') {
                    //   showErrorText(context, 'Enter Phone');
                    //   return;
                    // }
                    // if (_menuNameController.text == '') {
                    //   showErrorText(context, 'Enter Menu Name');
                    //   return;
                    // }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMenu(
                          resturantName: _restoNameController.text,
                          address: _addressController.text,
                          city: _cityController.text,
                          contact: _phoneController.text,
                          name: _menuNameController.text,
                        ),
                      ),
                    );
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
