import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';

Widget surveyHeader() {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Image',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          Container(
            height: 45,
            width: 1,
            color: QRTheme.mainColor,
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Description',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          Container(
            height: 45,
            width: 1,
            color: QRTheme.mainColor,
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Select Vote',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                fontFamily: 'Mulish',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
