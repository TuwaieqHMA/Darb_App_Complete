import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/circle_painter.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [signatureBlueColor, sandYellowColor,], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.65, 1])
            ),
          ),
          CustomPaint(
              painter: CirclePainter(
                circleColors: [fadedwhiteColor, fadedGreenColor, fadedwhiteColor],
                context: context),
                child: Center(
                  child: Image.asset("assets/images/darb_text_logo.png"),
                )
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset("assets/images/location_drawing.png"),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset("assets/images/bus_drawing.png")),
        ],
      ),
    );
  }

}

