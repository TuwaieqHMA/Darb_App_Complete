import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';

class GoToButton extends StatelessWidget {
  const GoToButton({
    super.key, required this.text, this.color = lightGreenColor, this.onTap, this.height = 26, this.isStudent = false
  });
  final String text;
  final Color? color;
  final double? height;
  final bool? isStudent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 131,
      child: ElevatedButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 8, right: 32)),
          minimumSize: MaterialStatePropertyAll(Size(context.getWidth(), height!),),
          backgroundColor: MaterialStatePropertyAll(color),
        ),
        onPressed: onTap, child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(text, style: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 16, overflow: TextOverflow.ellipsis),)),
          isStudent! ? nothing :  const Icon(Icons.arrow_forward_ios_rounded, color: whiteColor,),
        ],
      )),
    );
  }
}

