import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgTextBar extends StatelessWidget {
  const SvgTextBar({
    super.key,
    required this.text, required this.svgUrl, this.textColor = blackColor, this.iconWidth, this.iconHeight, this.width,
  });

  final String text;
  final Color? textColor;
  final String svgUrl;
  final double? iconWidth;
  final double? iconHeight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          SvgPicture.asset(svgUrl, width: iconWidth, height: iconHeight,),
          width8,
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: inukFont,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}