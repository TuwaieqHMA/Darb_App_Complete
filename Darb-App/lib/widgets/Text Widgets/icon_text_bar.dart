import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconTextBar extends StatelessWidget {
  const IconTextBar({
    super.key, required this.text, required this.icon, this.fontSize = 16, this.iconColor = signatureYellowColor, this.textDecoration, this.direction, this.textColor = blackColor,
  });

  final String text;
  final IconData icon;
  final double? fontSize;
  final Color? iconColor;
  final TextDecoration? textDecoration;
  final Color? textColor;
  final TextDirection? direction;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: direction,
      children: [
        Icon(icon, color: iconColor, size: 23,),
        width8,
        SizedBox(
          width: context.getWidth() * .3,
          child: Text(
            text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontFamily: inukFont, fontSize: fontSize, decoration: textDecoration, decorationColor: textColor), textDirection: direction,),
        )
      ],
    );
  }
}