import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_code_generator/apis/base_url.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ShowQR extends StatefulWidget {
  ShowQR({ Key? key , required this.image}) : super(key: key);

  var image;

  @override
  State<ShowQR> createState() => _ShowQRState();
}

class _ShowQRState extends State<ShowQR> {

  @override
  Widget build(BuildContext context) {

    UriData? data = Uri.parse(widget.image).data;
    Uint8List bytes = data!.contentAsBytes();

    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Show QR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            fontFamily: 'Mulish',
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.memory(bytes))
      ]),

    );
  }
}