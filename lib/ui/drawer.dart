import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/signin_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/history.dart';
import 'package:qr_code_generator/ui/login.dart';
import 'package:qr_code_generator/widgets/drawer_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'invite_friends.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user;

  @override
  initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QRTheme.mainMaterialColor,
      body: Column(
        children: [
          SizedBox(
            width: 400,
            height: 150,
            child: user != null
                ? Material(
                    color: Colors.black87,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(maxRadius: 32),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 16.0),
                                  child: Text(
                                    '${user!.firstName} ${user!.lastName}',
                                    // 'Mukhtar Abbas',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'Mulish',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    '${user!.email}',
                                    // 'mukhtarabbas4445@gmail.com',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'Mulish',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const CupertinoActivityIndicator(),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const History()));
                    },
                    child: DrawerItem(
                      text: 'Create History',
                      image: 'create_history',
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child:
                          DrawerItem(text: 'Scan History', image: 'history')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InviteFriends()));
                      },
                      child: DrawerItem(text: 'Settings', image: 'settings')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child: DrawerItem(text: 'Feedback', image: 'star')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child: DrawerItem(text: 'Language', image: 'languages')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child: DrawerItem(text: 'Rate us', image: 'star')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child: DrawerItem(text: 'Share App', image: 'share')),
                  // SizedBox(height: 120),
                  // Expanded(child: Container()),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Image.asset('assets/sign_out.png'),
                  //   iconSize: 70,
                  // ),
                  MaterialButton(
                    onPressed: () {
                      logOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Image.asset('assets/sign_out.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future logOut() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  Future getProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('userDetails') != null) {
      var userDetails = sp.getString('userDetails');
      SignInResponse signInResponse =
          SignInResponse.fromJson(jsonDecode(userDetails!));
      user = signInResponse.user!;
    }
    setState(() {});
  }
}
