import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_generator/ui/create_qr_code.dart';
import 'package:qr_code_generator/widgets/bottom_app_bar.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key, this.menu}) : super(key: key);
  final MenuResponse? menu;
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  String? text = '';
  @override
  initState() {
    super.initState();
    createText();
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
          'Invite Friends',
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
        child: Column(
          children: [
            InkWell(
              onTap: () {
                whatsAppNow();
              },
              child: inviteListTile('Invite Friends by Whatsapp'),
            ),
            InkWell(
              onTap: () {
                launchEmail();
              },
              child: inviteListTile('Invite Friends by Email'),
            ),
            InkWell(
              onTap: () {
                launchEmail();
              },
              child: inviteListTile('Invite Friends by SMS'),
            ),
            InkWell(
              onTap: () {
                launchEmail();
              },
              child: inviteListTile('Invite Friends by Others'),
            ),
          ],
        ),
      ),
    );
  }

  Widget inviteListTile(text) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        '$text',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 18,
          fontFamily: 'Mulish',
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
      ),
    );
  }

  Future whatsAppNow() async {
    var url =
        "https://wa.me/?text= Hey Man This is awesome menu of restaurant. ${jsonEncode(widget.menu!.menu!.toJson().remove('headerImg'))}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchEmail() async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(text!,
        subject: 'Restaurant Menu ',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  createText() {
    text = 'Restaurant Menu ';
    _redraw();
  }

  _redraw() {
    if (mounted) setState(() {});
  }
}
