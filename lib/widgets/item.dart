import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';

Widget singleItem(Items item) {
  return Column(
    children: [
      const Divider(color: Colors.white70),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          rdValueText(item.id!.toString().substring(0, 1)),
          rdValueText(item.name),
          rdValueText(item.price),
          // rdValueText('@'),
          const Icon(
            Icons.task_alt_rounded,
            color: Colors.white,
          ),
        ],
      ),
    ],
  );
}
