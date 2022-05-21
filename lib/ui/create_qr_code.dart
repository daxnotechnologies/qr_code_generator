import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/add_restaurant_menu.dart';
import 'package:qr_code_generator/ui/create_survey.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/bottom_app_bar.dart';
import 'package:qr_code_generator/widgets/single_big_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateQRCode extends StatefulWidget {
  const CreateQRCode({Key? key}) : super(key: key);

  @override
  _CreateQRCodeState createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create QR Code',
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
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(Icons.add),
        onPressed: () {},
        backgroundColor: QRTheme.mainColor,
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
                      'Select One',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddRestaurantMenu(),
                          ),
                        );
                      },
                      child: singleBigButton(
                          context, 'Restaurant', Icons.restaurant_menu_sharp),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateSurvey(),
                          ),
                        );
                      },
                      child:
                          singleBigButton(context, 'Survey', Icons.content_paste),
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Restaurant'),
                                        onTap: () {
                                          Navigator.pop(context, 'Restaurant');
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('Survey'),
                                        onTap: () {
                                          Navigator.pop(context, 'Survey');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                        print('$response');
                        createFolder(response.toString().toLowerCase());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CreateSurvey(),
                        //   ),
                        // );
                      },
                      child: singleBigButton(
                          context, 'Folder', Icons.folder_outlined),
                      // singleBigButton(
                      //     context, 'More', Icons.more_horiz_sharp),
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                    child: Text(
                      'My QR List',
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
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 15.0, bottom: 8.0),
                child: SizedBox(
                  height: 40,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {},
                      decoration: searchInputDecoration.copyWith(
                        hintText: 'Search QR Code',
                        prefixIcon: Icon(
                          Icons.search,
                          color: QRTheme.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'May 02,2021',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 442,
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      InkWell(
                        onLongPress: () {
                          print('long press');
                        },
                        child: listTile(
                            context, 'Restaurant', Icons.restaurant_menu_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createFolder(String? folderName) async {
    List<String>? folder;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getStringList('${folderName}Folder') != null) {
      folder = sp.getStringList('${folderName}Folder');
    } else {
      folder = [];
    }
    // Menu? menu;
    // var menuString = jsonEncode(menu!.toJson());
    // folder!.add(menuString);
    sp.setStringList('${folderName}Folder', folder!);
    print('menu saved in restaurantFolder');
  }
}
