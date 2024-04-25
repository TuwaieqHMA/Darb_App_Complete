import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({
    super.key,
    required this.text,
    required this.number,
    required this.backgroundColor,
  });

  final String text;
  final int number;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: whiteColor,
              fontFamily: inukFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$number',
            style: const TextStyle(
              color: whiteColor,
              fontFamily: inukFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

