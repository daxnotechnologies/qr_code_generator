import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';

Widget simpleText(text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 12,
      fontFamily: 'Mulish',
    ),
  );
}

Widget rdValueText(text) {
  //rdValueText =TextValues about Restaurant Details
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      '$text',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 22,
        fontFamily: 'Mulish',
      ),
    ),
  );
}

Widget ffMenuHeaderText(text) {
  //rdValueText =TextValues about Restaurant Details
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      '$text',
      style: TextStyle(
        color: QRTheme.mainColor,
        fontWeight: FontWeight.w900,
        fontSize: 22,
        fontFamily: 'Mulish',
      ),
    ),
  );
}

Widget rdKeyText(text) {
  //rdKeyText =TextKeys about Restaurant Details
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      '$text',
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w900,
        fontSize: 18,
        fontFamily: 'Mulish',
      ),
    ),
  );
}
