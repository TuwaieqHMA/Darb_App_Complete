import 'package:flutter/widgets.dart';

class CircleCustomAvatar extends StatelessWidget {
  const CircleCustomAvatar({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(borderRadius: BorderRadius.circular(60),child: child));
  }
}
