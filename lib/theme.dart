import 'package:flutter/material.dart';

int _yellowPrimaryValue = 0xFF1DBF73;

class QRTheme {
  static Color mainColor = const Color.fromRGBO(29, 191, 115, 1);
  static Color googleColor = const Color.fromRGBO(252, 106, 87, 1);
  static Color facebookColor = const Color.fromRGBO(41, 143, 255, 1);

  static MaterialColor mainMaterialColor = MaterialColor(
    _yellowPrimaryValue,
    const <int, Color>{
      50: Color.fromRGBO(29, 191, 115, 1),
      100: Color.fromRGBO(29, 191, 115, 1),
      200: Color.fromRGBO(29, 191, 115, 1),
      300: Color.fromRGBO(29, 191, 115, 1),
      400: Color.fromRGBO(29, 191, 115, 1),
      500: Color.fromRGBO(29, 191, 115, 1),
      600: Color.fromRGBO(29, 191, 115, 1),
      700: Color.fromRGBO(29, 191, 115, 1),
      800: Color.fromRGBO(29, 191, 115, 1),
      900: Color.fromRGBO(29, 191, 115, 1),
    },
  );
}
