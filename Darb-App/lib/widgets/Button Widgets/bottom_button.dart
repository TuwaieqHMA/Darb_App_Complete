import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key, this.onPressed, required this.text, this.color = signatureYellowColor, this.textColor = deepBlueColor, this.fontSize = 16, this.width,
  });

  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final double? fontSize;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: width ?? context.getWidth(),
      height: 50,
      splashColor: fadedwhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style:  TextStyle(color: textColor, fontFamily: inukFont, fontSize: fontSize, fontWeight: FontWeight.bold),),);
  }
}