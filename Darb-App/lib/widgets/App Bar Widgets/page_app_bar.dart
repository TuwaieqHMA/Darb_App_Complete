import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  const PageAppBar({
    super.key,
    required this.title,
    this.actionButton,
    this.textColor = signatureBlueColor,
    this.backgroundColor = offWhiteColor,
    this.bottom,
    this.elevation,
  });

  final String title;
  final Widget? actionButton;
  final Color? textColor;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: elevation,
        automaticallyImplyLeading: false,
        toolbarHeight: 82,
        leading: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height24,
            CircleBackButton(),
          ],
        ),
        title: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontFamily: inukFont,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [actionButton ?? nothing],
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        bottom: bottom);
  }
}
