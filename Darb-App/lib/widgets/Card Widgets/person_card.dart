import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
    required this.user,
    required this.name,
    this.isSigned,
    this.onView,
    this.onEdit,
    this.onDelete
  });

  final DarbUser user; 
  final String name;
  final bool? isSigned;
  final Function()? onView;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: 52,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/icons/circle_person_icon.svg"),
          width8,
          Expanded(
              child: Text(
            name,
            style: const TextStyle(
              color: signatureTealColor,
              fontFamily: inukFont,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          width8,
          (isSigned != null)
              ? Text(
                  isSigned! ? "مسجل" : "غير مسجل",
                  style: TextStyle(
                      color: isSigned! ? greenColor : redColor,
                      fontFamily: inukFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              : nothing,
          MoreButton(
            onViewClick: onView,
            onEditClick: 
              onEdit,
            onDeleteClick: onDelete,
          )

        ],
      ),
    );
  }
}


