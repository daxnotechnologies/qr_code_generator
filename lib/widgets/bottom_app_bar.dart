import 'package:flutter/material.dart';
import 'package:qr_code_generator/ui/history.dart';
import 'package:qr_code_generator/ui/home.dart';
import 'package:qr_code_generator/ui/invite_friends.dart';
import 'package:qr_code_generator/ui/profile.dart';

Widget bottomAppBar(context) {
  return BottomAppBar(
    notchMargin: 4,
    shape: const CircularNotchedRectangle(),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                ),
              ),
            ),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.history),
              ),
            ),
            const SizedBox(width: 32, height: 32),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InviteFriends(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.settings_outlined),
              ),
            ),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person_outline_outlined),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
