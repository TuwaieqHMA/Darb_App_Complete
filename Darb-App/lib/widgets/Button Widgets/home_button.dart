import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key, this.onPressed, required this.text, this.color = signatureYellowColor, this.textColor = deepBlueColor, this.fontSize = 16,
  });

  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: context.getWidth(),
      height: 70,
      splashColor: fadedwhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style:  TextStyle(color: textColor, fontFamily: inukFont, fontSize: fontSize, fontWeight: FontWeight.bold),),));
  }
}