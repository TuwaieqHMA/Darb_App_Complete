import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/Button%20Widgets/go_to_button.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key, required this.text, required this.icon, this.buttonText = "عرض", required this.color, this.buttonColor = signatureYellowColor, this.onTap, this.margin = 32, this.image
  });

  final String text;
  final Widget icon;
  final Color color;
  final String? buttonText;
  final Color? buttonColor;
  final String? image;
  final double? margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: context.getHeight() * .23,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: margin!),
      
      decoration: BoxDecoration(
        image: image != null ?  DecorationImage(image: AssetImage(image!), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop) ) : null,
        color: color,
        borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(text, style: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 24, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), maxLines: 1,)),
                icon,
              ],
            ),
            GoToButton(text: buttonText!, color: buttonColor, height: 32, onTap: onTap)
          ],
        ),
    );
  }
}