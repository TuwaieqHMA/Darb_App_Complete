import 'package:flutter/material.dart';

class CircleCustomButton extends StatelessWidget {
  const CircleCustomButton({
    super.key, this.onPressed, required this.icon, this.iconColor, this.backgroundColor, this.iconSize, this.circleSize,
  });

  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;
  final Size? circleSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: IconButton(
        onPressed: onPressed,
        icon:  Icon(
          icon,
          color: iconColor,
        ),
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(iconSize),
          minimumSize: MaterialStatePropertyAll(circleSize),
            backgroundColor:
                MaterialStatePropertyAll(backgroundColor)),
      ),
    );
  }
}
