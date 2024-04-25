import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    this.onViewClick,
    this.onEditClick,
    this.onDeleteClick, this.padding,
  });

  final Function()? onViewClick;
  final Function()? onEditClick;
  final Function()? onDeleteClick;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: const Offset(-32, 0),
        builder: (context, controller, child) {
          return IconButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(padding)
            ),
            padding: padding,
            constraints: (padding != null) ? const BoxConstraints() : null,
            onPressed: (controller.open),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: signatureTealColor,
            ),
          );
        },
        style: MenuStyle(
          elevation: const MaterialStatePropertyAll(10),
          surfaceTintColor: const MaterialStatePropertyAll(offWhiteColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
        ),
        menuChildren: [
          MenuItemButton(
              onPressed: onViewClick,
              leadingIcon: const Icon(
                Icons.remove_red_eye,
                color: signatureTealColor,
              ),
              child: const Text(
                "عرض",
                style: TextStyle(
                    color: signatureTealColor,
                    fontFamily: inukFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )),         
          MenuItemButton(
              onPressed: onEditClick,
              leadingIcon: const Icon(
                Icons.edit,
                color: signatureYellowColor,
              ),
              child: const Text(
                "تعديل",
                style: TextStyle(
                    color: signatureYellowColor,
                    fontFamily: inukFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )),
          MenuItemButton(
              onPressed: onDeleteClick,
              leadingIcon: const Icon(
                Icons.delete,
                color: redColor,
              ),
              child: const Text(
                "حذف",
                style: TextStyle(
                    color: redColor,
                    fontFamily: inukFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )),
        ]);
  }
}