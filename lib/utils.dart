import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';

final fInputDecor = InputDecoration(
  hintText: 'Enter your email',
  labelStyle: TextStyle(
    color: QRTheme.mainColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: QRTheme.mainColor,
      width: 2.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: QRTheme.mainColor,
      width: 2.0,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: QRTheme.mainColor,
      width: 2.0,
    ),
  ),
);

InputDecoration searchInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  labelStyle: textStyle,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(27),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.white,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(27),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.white,
    ),
  ),
  // hintText: 'Search Places...',
  // prefixIcon: Image.asset('assets/png/search.png'),
  // suffixIcon: Image.asset('assets/png/calendar.png'),

  //  SizedBox(
  //   width: 12,
  //   height: 12,
  //   child:
  // SvgPicture.asset(
  //   'assets/svg/search.svg',
  //   width: 12,
  // ),
  // ),
  // suffixIcon: SizedBox(
  //   child: SvgPicture.asset(
  //     'assets/svg/calender.svg',
  //     width: 24,
  //     height: 24,
  //   ),
  // ),

  //  const Icon(
  //   Icons.search_outlined,
  //   color: myGrey,
  // ),
  // suffixIcon: const Icon(
  //   Icons.schedule,
  //   color: myGrey,
  // ),
);
const textStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16,
);

final itemStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  fontFamily: 'Mulish',
  color: QRTheme.mainColor,
);
var myBoxDecoration = BoxDecoration(
  color: const Color.fromARGB(255, 242, 242, 242),
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 7,
      offset: const Offset(1, 1),
      color: Colors.grey.withOpacity(0.2),
    ),
  ],
);

var myInputDecoration = InputDecoration(
  hintText: 'Mobile No',
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Colors.white,
      width: 1,
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);
