import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';

class ContainerTracking extends StatelessWidget {
  const ContainerTracking({
    super.key,
    required this.text,
    required this.color,
    required this.height,
    required this.img, this.imgWidth = 40,
  });
  final String text;
  final Color color;
  final double height;
  final String img;
  final double? imgWidth;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            img,
            width: imgWidth,
          ),
          width8,
          Expanded(
            child: Container(
              height: height,
              width: context.getWidth(),
              padding: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: offWhiteColor,
                  border: Border(right: BorderSide(color: color, width: 6))),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: signatureBlueColor,
                    fontFamily: inukFont,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}