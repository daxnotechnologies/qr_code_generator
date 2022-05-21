import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  String? text;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Image.asset(
                'assets/$image.png',
                height: 32,
                width: 32,
              ),
              const SizedBox(width: 20),
              Text(
                text!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Mulish',
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 78, right: 78),
          child: Divider(
            color: Colors.white,
            thickness: 0.5,
            height: 32,
          ),
        ),
      ],
    );
  }
}
