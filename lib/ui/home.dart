import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_code_generator/apis/apis.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/ui/edit_restaurant_menu.dart';
import 'package:qr_code_generator/ui/restaurant_menu.dart';
import 'package:qr_code_generator/widgets/bottom_app_bar.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/create_qr_code.dart';
import 'package:qr_code_generator/ui/drawer.dart';
import 'package:qr_code_generator/ui/scan_now.dart';

import '../utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  int? buttonIndex = 0;

  var folderName;

  @override
  initState() {
    getFolders();
    super.initState();
    getScanHistory();
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
          'Home',
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
        actions: const [CircleAvatar()],
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
              builder: (context) => const CreateQRCode(),
            ),
          );
        },
        backgroundColor: QRTheme.mainColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                      hintText: 'Search QR Code',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color: QRTheme.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanNow(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                size: 40,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Tap To Scan QR Code',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                      getScanHistory();
                    },
                    child: homeMiniButton('Scan History', buttonIndex == 1),
                  ),
                  InkWell(
                    onTap: () {
                      buttonIndex = 2;
                      _redraw();
                      getFolders();
                    },
                    child: homeMiniButton('Folders', buttonIndex == 2),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 467,
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
                                      onLongPress: () async {
                                        final response = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                children: [
                                                  Column(
                                                    children: [
                                                      ListTile(
                                                        title: const Text(
                                                            'Restaurant'),
                                                        onTap: () {
                                                          Navigator.pop(context,
                                                              'Restaurant');
                                                        },
                                                      ),
                                                      ListTile(
                                                        title:
                                                            const Text('Survey'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context, 'Survey');
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                        print('$response');
                                        addToRestaurant('restaurant', menu);
                                      },
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
                          : folderList != null ? Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListView.builder(
                              itemCount: folderList!.length,
                              itemBuilder: (context, index) {
                                return folderTile(context, folderList![index],  Icons.folder);
                              },
                            ),
                          ) : ffMenuHeaderText('No Folder'),
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

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString('folders');

    var response = jsonDecode(sharedPreferences.getString('userDetails')!);
    var id = response['user']['_id'];


    Map userFolders = jsonDecode(temp!);
    Map? userFolder = userFolders['$id']; 
    folderList = userFolder == null ? [] : userFolder['folders'];

  }

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
      _redraw();
    }
    print("scan QRList length ${scanQRList!.length}");
  }

  addToRestaurant(folderName, menu) async {
    List<String>? folder;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getStringList('${folderName}Folder') != null) {
      folder = sp.getStringList('${folderName}Folder');
    } else {
      folder = [];
    }
    Menu? menu;
    var menuString = jsonEncode(menu!.toJson());
    folder!.add(menuString);
    sp.setStringList('${folderName}Folder', folder);
    print('menu saved in restaurantFolder');
  }
}

Widget listTile(context, text, icon, {MenuResponse? menu}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          color: QRTheme.mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.restaurant_menu,
          color: Colors.white,
        ),
      ),
      title: const Text('Restaurant'),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                editMenu(context, menu);
              },
              icon: Icon(
                Icons.edit,
                color: QRTheme.mainColor,
              ),
            ),
            IconButton(
              onPressed: () {
                AppAPIs api= new AppAPIs();
                api.deleteMenu(menu!.menu!.sId);
              },
              icon: Icon(
                Icons.delete_outlined,
                color: QRTheme.mainColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget folderTile(context, text, icon, {MenuResponse? menu}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          color: QRTheme.mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon, // Icons.folder_open_rounded,
          color: Colors.white,
        ),
      ),
      title: Text('$text'),
      trailing: IconButton(
        onPressed: () {
          
        },
        icon: Icon(
          Icons.delete,
          color: QRTheme.mainColor,
        ),
      ),
    ),
  );
}

editMenu(context, menu) {
  //
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditRestaurantMenu(menu: menu),
    ),
  );
}

Widget homeMiniButton(text, isSelected) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected ? QRTheme.mainColor : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? QRTheme.mainColor : Colors.black54,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$text',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    ),
  );
}
