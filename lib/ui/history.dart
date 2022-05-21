import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/models/qr_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/add_restaurant_menu.dart';
import 'package:qr_code_generator/ui/create_qr_code.dart';
import 'package:qr_code_generator/ui/drawer.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/ui/restaurant_menu.dart';
import 'package:qr_code_generator/utils.dart';
import 'package:qr_code_generator/widgets/bottom_app_bar.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  int? buttonIndex = 0;

  @override
  initState() {
    super.initState();
    getScanHistory();
    getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            fontFamily: 'Mulish',
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: QRTheme.mainColor,
          )
        ],
      ),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateQRCode(),
            ),
          );
        },
        backgroundColor: QRTheme.mainColor,
        // shape: shape,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      buttonIndex = 0;
                      _redraw();
                    },
                    child: homeMiniButton('Recent Scan', buttonIndex == 0),
                  ),
                  InkWell(
                    onTap: () {
                      buttonIndex = 1;
                      _redraw();
                    },
                    child: homeMiniButton('Scan History', buttonIndex == 1),
                  ),
                  InkWell(
                    onTap: () {
                      buttonIndex = 2;
                      _redraw();
                    },
                    child: homeMiniButton('Folders', buttonIndex == 2),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 8.0, bottom: 24.0),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(27),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {},
                    decoration: searchInputDecoration.copyWith(
                      hintText: 'Search QR Code History',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 271,
                child: SingleChildScrollView(
                  child: buttonIndex == 1
                      ? (scanQRList!.isEmpty
                          ? ffMenuHeaderText('No scan history')
                          : Wrap(
                              children: scanQRList!.map((menu) {
                                return Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantMenu(menu: menu),
                                        ),
                                      );
                                    },
                                    child: listTile(
                                      context,
                                      'Restaurant',
                                      Icons.restaurant_menu_rounded,
                                      menu: menu,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ))
                      : buttonIndex == 0
                          ? (scanQRList!.isEmpty
                              ? ffMenuHeaderText('No Recent scan')
                              : Wrap(
                                  children: scanQRList!.map((menu) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RestaurantMenu(menu: menu),
                                          ),
                                        );
                                      },
                                      child: listTile(
                                        context,
                                        'Restaurant',
                                        Icons.restaurant_menu_rounded,
                                        menu: menu,
                                      ),
                                    );
                                  }).toList(),
                                ))
                          : (folderList!.isEmpty
                              ? ffMenuHeaderText('No Folder')
                              : Column(
                                  children: [
                                    restaurantFolder!
                                        ? folderTile(context,
                                            'Restaurant Folders', Icons.folder)
                                        : Container(),
                                    surveyFolder!
                                        ? folderTile(context, 'Survey Folders',
                                            Icons.folder)
                                        : Container(),
                                  ],
                                )),

                  //  buttonIndex == 1
                  //     ? Wrap(
                  //         children: scanQRList!.map((menu) {
                  //           return Container(
                  //             child: InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         RestaurantMenu(menu: menu),
                  //                   ),
                  //                 );
                  //               },
                  //               child: listTile(context, 'Restaurant',
                  //                   Icons.restaurant_menu_rounded),
                  //             ),
                  //           );
                  //         }).toList(),
                  //       )
                  //     : buttonIndex == 0
                  //         ? ffMenuHeaderText('No Recent scan')
                  //         : ffMenuHeaderText('No Folder'),
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

  List? folderList = [];
  bool? restaurantFolder = false;
  bool? surveyFolder = false;
  Future getFolders() async {
    List<String>? folder;
    folderList = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getStringList('restaurantFolder') != null) {
      folder = sp.getStringList('restaurantFolder');
      folderList!.add('Restaurant Folder');
      restaurantFolder = true;
    } else {
      folder = [];
    }
    if (sp.getStringList('surveyFolder') != null) {
      folder = sp.getStringList('surveyFolder');
      folderList!.add('Survey Folder');
      surveyFolder = true;
    } else {
      folder = [];
    }
    _redraw();
    // Menu? menu;
    // var menuString = jsonEncode(menu!.toJson());
    // folder!.add(menuString);
    // sp.setStringList('restaurantFolder', folder!);
    print('menu saved in restaurantFolder');
  }

  // List<QRResponse>? scanQRList;
  List<MenuResponse>? scanQRList = [];

  Future getScanHistory() async {
    List<String>? scanList;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getStringList('scanList') != null) {
      scanList = sp.getStringList('scanList');
    } else {
      scanList = [];
    }
    scanQRList = [];
    for (var i = 0; i < scanList!.length; i++) {
      MenuResponse menuResponse =
          MenuResponse.fromJson(jsonDecode(scanList[i]));
      scanQRList!.add(menuResponse);
    }
  }
}
