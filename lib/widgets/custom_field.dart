import 'package:flutter/material.dart';
import 'package:qr_code_generator/utils.dart';

Widget simpleField(controller, hint, icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
    child: TextFormField(
      controller: controller,
      enabled: true,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Mulish',
      ),
      decoration: fInputDecor.copyWith(
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
