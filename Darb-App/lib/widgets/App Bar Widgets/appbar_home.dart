import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key, required this.tital, this.onTap, this.icon});
  final String tital;
  final Function()? onTap;
  final Widget? icon;
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: context.getWidth(),
        height: context.getWidth() * 0.90,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: lightGreenColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height24,
                Row(
                  children: [
                    InkWell(onTap: onTap, child: icon),
                    width16,
                    Text(
                      tital,
                      style: const TextStyle(
                          color: whiteColor,
                          fontSize: 26,
                          fontFamily: inukFont),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.getWidth() * 0.23,
                  height: context.getWidth() * 0.25,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/app_logo.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
