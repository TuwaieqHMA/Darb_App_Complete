import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';


class SupervisorAddCard extends StatelessWidget {
  const SupervisorAddCard(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.isPadding,
      required this.img,
      required this.img1,
      required this.mianAxis,
      required this.crossAxis,
      required this.imgColor,
      required this.onTap});
  final String text;
  final Color bgColor;
  final String img;
  final Color imgColor;
  final bool img1;
  final MainAxisAlignment mianAxis;
  final CrossAxisAlignment crossAxis;
  final bool isPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth() * 0.92,
      height: context.getHeight() * 0.27, 
      margin: const EdgeInsets.only(
        top: 24,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          width16,
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 38, 
                  height: 40, 
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(60, 250, 246, 238),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 25,
                  ),
                ),
                width8,
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: inukFont,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: mianAxis,
            crossAxisAlignment: crossAxis,
            children: [
              Stack(
                children: [
                  Image.asset(
                    img,
                    color: imgColor,
                  ),
                  img1
                      ? Positioned(
                          top: 30,
                          left: 10,
                          child: Image.asset(
                            "assets/images/school_bus.png",
                            color: const Color.fromARGB(255, 48, 126, 126),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          isPadding
            ? width16
            : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
