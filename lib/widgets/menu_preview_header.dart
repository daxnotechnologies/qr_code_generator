import 'package:flutter/material.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';

Widget menuPreviewHeader() {
  return Padding(
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
  );
}
