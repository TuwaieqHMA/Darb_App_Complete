import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {

  CirclePainter({this.circleColors = const [blackColor], required this.context});
  final List<Color> circleColors;
  final BuildContext context;
  @override
  void paint(Canvas canvas, Size size,) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = circleColors[0];
    paint.style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: Offset(context.getWidth()/2, context.getHeight()/2), width: 300,  height: 300), 3.8, 4.8, false, paint);
    paint.color = circleColors[1];
    canvas.drawArc(Rect.fromCenter(center: Offset(context.getWidth()/2, context.getHeight()/2), width: 250,  height: 250), 0, 5, false, paint);
    paint.color = circleColors[2];
    canvas.drawArc(Rect.fromCenter(center: Offset(context.getWidth()/2, context.getHeight()/2), width: 200,  height: 200), 1.8, 5.3, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  }