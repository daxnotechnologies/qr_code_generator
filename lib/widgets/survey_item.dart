import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/all_surveys.dart';
import 'package:qr_code_generator/theme.dart';

// var surveyItemDesc =
//     'Lorem ipsum dolor sit amet, \nconsectetur adipiscing elit. \nFeugvulputate et, laoreet.';

Widget surveyItem(Surveys survey) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: QRTheme.mainColor,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(survey.image!),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '${survey.description!}',
                  // surveyItemDesc,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.task_alt_rounded,
            color: QRTheme.mainColor,
          ),
        ],
      ),
    ),
  );
}
