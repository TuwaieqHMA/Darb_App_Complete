import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key, this.color = signatureYellowColor, required this.icon, required this.text, this.onTap, this.textColor = deepBlueColor, this.shadowColor = fadedGreenColor,
  });

  final Color? color;
  final FaIcon icon;
  final String text;
  final Color? textColor;
  final Color? shadowColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.getWidth(),
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow:  [
            BoxShadow(color: shadowColor!, offset: const Offset(0, 4), blurRadius: 10),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(text, style: TextStyle(color: textColor, fontFamily: inukFont, fontSize: 24, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), maxLines: 1,)
          ],
        ),
      ),
    );
  }
}