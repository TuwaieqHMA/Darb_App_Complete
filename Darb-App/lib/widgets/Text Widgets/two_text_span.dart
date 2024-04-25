import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TwoTextSpan extends StatelessWidget {
  const TwoTextSpan({
    super.key, required this.normalText, required this.underlinedText, this.onTap, this.textAlign = TextAlign.center,
  });

  final String normalText;
  final String underlinedText;
  final Function()? onTap;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign!,
      text:  TextSpan(
        style: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 16, fontWeight: FontWeight.bold),
        children: [
      TextSpan(text: normalText,),
      TextSpan(text: underlinedText, style: const TextStyle(decoration: TextDecoration.underline, decorationThickness: 2, overflow: TextOverflow.fade), recognizer: TapGestureRecognizer()..onTap = onTap),
    ]));
  }
}
