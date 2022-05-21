import 'package:flutter/material.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/home.dart';

class AllWidgets {
  static Widget text1(text, color) {
    return Text(
      '$text',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w900,
        fontSize: 35,
        fontFamily: 'Mulish',
      ),
    );
  }

  static Widget text2(text, color) {
    return Text(
      '$text',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 35,
        // fontFamily: 'Mulish',
      ),
    );
  }

  static Widget button1(context, text, function) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        height: 64,
        elevation: 4.0,
        color: QRTheme.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 21,
            fontFamily: 'Mulish',
          ),
        ),
        onPressed: function,
        // () {
        // function;
        // print('in widget');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OnBoarding2(),
        //   ),
        // );
        // },
      ),
    );
  }
}

Widget socialButton(context, text, color, function) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 20,
    ),
    child: MaterialButton(
      minWidth: 160,
      height: 50,
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 21,
          fontFamily: 'Mulish',
        ),
      ),
      onPressed: function,
      //  () {
      //   function;
      //   // Navigator.pushReplacement(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => Home(),
      //   //   ),
      //   // );
      // },
    ),
  );
}

class BarButton extends StatelessWidget {
  const BarButton({
    Key? key,
    this.buttonName,
    this.buttonIcon,
    this.authenticate,
    this.selected,
  }) : super(key: key);

  final bool? selected;
  final String? buttonName;
  final IconData? buttonIcon;
  final Function? authenticate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Icon(
                  buttonIcon!,
                  color: QRTheme.mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
