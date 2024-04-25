import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key, required this.text, this.color, this.onPressed,
  });

  final String text;
  final Color? color;
  final Function()? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(color),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: const MaterialStatePropertyAll(Size(94, 32))
    ), child: Text(text, style: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 18),),);
  }
}
