import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class NoItemText extends StatelessWidget {
  const NoItemText({
    super.key, this.text, this.isLoading = false, this.textColor = blackColor, this.height = 136,
  });

  final String? text;
  final bool? isLoading;
  final Color? textColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: height,
      child: Center(child: (isLoading!) ? const CircularProgressIndicator(color: signatureYellowColor,) : Text(text!, style: TextStyle(color: textColor, fontFamily: inukFont, fontSize: 18,),)));
  }
}