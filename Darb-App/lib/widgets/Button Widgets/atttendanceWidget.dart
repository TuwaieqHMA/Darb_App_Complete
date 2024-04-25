import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class PresenceStatusButton extends StatelessWidget {
  const PresenceStatusButton({super.key, required this.status, this.onTap});

  final AttendanceStatus status;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
        border: Border.all(color: (status == AttendanceStatus.assueredPrecense) ? signatureYellowColor : (status == AttendanceStatus.present) ? signatureTealColor : redColor, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            (status == AttendanceStatus.assueredPrecense) ? "انتظار" : (status == AttendanceStatus.present) ? "حاضر" : "غائب",
            style: TextStyle(
              color: (status == AttendanceStatus.assueredPrecense) ? signatureYellowColor : (status == AttendanceStatus.present) ? signatureTealColor : redColor,
              fontFamily: inukFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}