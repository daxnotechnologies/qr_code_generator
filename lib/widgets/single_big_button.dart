import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';

Widget singleBigButton(context, text, icon) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.width * 0.3,
    decoration: BoxDecoration(
      color: QRTheme.mainColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, size: 40, color: QRTheme.mainColor),
            ),
          ),

          Text(
            '$text',
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(color: Colors.white,fontSize: 14, fontFamily: 'Mulish'),
          ),
        ],
      ),
    ),
  );
}
