import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/widgets.dart';

showErrorText(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: socialButton(
        context,
        '$text',
        QRTheme.googleColor,
        () {},
      ),
    ),
  );
}

showSuccessMessage(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: socialButton(
        context,
        '$text',
        QRTheme.mainColor,
        () {},
      ),
    ),
  );
}
