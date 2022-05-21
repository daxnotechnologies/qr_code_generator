import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/bucket.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({Key? key, this.menu}) : super(key: key);
  final MenuResponse? menu;
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  double? total = 0.0;
  @override
  initState() {
    super.initState();
    calculateTotal();
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
            mainAxisAlignment: MainAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: QRTheme.mainColor,
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rdKeyText('Inv Number'),
                          rdKeyText('Company'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rdValueText('#Invoice2020'),
                          // rdValueText('#Invoice2020'),
                          Container(width:MediaQuery.of(context).size.width*0.4,child: rdValueText('${widget.menu!.menu!.resturantName}')),
                          // rdValueText('Apple'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rdKeyText('City'),
                          rdKeyText('Phone Number'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rdValueText('${widget.menu!.menu!.city}'),
                          // rdValueText('Islamabad'),
                          rdValueText('${widget.menu!.menu!.contact}'),
                          // rdValueText('037548568364'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Fast Food Menu',
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
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: QRTheme.mainColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ffMenuHeaderText('Sr.no'),
                              ffMenuHeaderText('Item'),
                              ffMenuHeaderText('Price'),
                              ffMenuHeaderText('Bucket'),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: widget.menu!.menu!.items!.map((item) {
                          return Column(
                            children: [
                              const Divider(color: Colors.white70),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  rdValueText(
                                      '${item.id!.toString().substring(0, 1)}'),
                                  rdValueText('${item.name!}'),
                                  rdValueText('\$${item.price!}'),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.task_alt_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // rdValueText('@'),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                        /*
                         [
                          Column(
                            children: [
                              Divider(color: Colors.white70),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  rdValueText('3'),
                                  rdValueText('Pizza'),
                                  rdValueText('\$9.89'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.task_alt_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // rdValueText('@'),
                                ],
                              ),
                            ],
                          ),
                        ],

                        */
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ffMenuHeaderText('Total'),
                              ffMenuHeaderText('\$$total'),
                            ],
                          ),
                        ),
                      ),
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
                  child: Row(
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
                        'Add to Bucket',
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
                    await addToBucket();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bucket(menu: widget.menu),
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

  calculateTotal() {
    for (var element in widget.menu!.menu!.items!) {
      total = total! + int.parse(element.price!);
    }
    _redraw();
  }

  _redraw() {
    if (mounted) setState(() {});
  }

  Future addToBucket() async {
    List<String>? bucketStringList;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getStringList('bucketList') != null) {
      bucketStringList = sp.getStringList('bucketList');
    } else {
      bucketStringList = [];
    }
    Menu? menu = widget.menu!.menu;
    var menuString = jsonEncode(menu!.toJson());
    bucketStringList!.add(menuString);
    sp.setStringList('bucketList', bucketStringList);
    print('menu saved in bucket');
  }

  // List<Menu> bucketList = [];
  // Future getBucketList() async {
  //   List<String>? bucketStringList;
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   if (sp.getStringList('bucketList') != null) {
  //     bucketStringList = sp.getStringList('bucketList');
  //   } else {
  //     bucketStringList = [];
  //   }
  //   bucketList = [];
  //   for (var i = 0; i < bucketStringList!.length; i++) {
  //     Menu menu = Menu.fromJson(jsonDecode(bucketStringList[i]));
  //     bucketList.add(menu);
  //     _redraw();
  //   }
  //   print("scan bucketlist length ${bucketList.length}");
  // }

}
