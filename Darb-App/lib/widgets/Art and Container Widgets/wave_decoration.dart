import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';

class WaveDecoration extends StatelessWidget {
  const WaveDecoration({super.key, required this.containerColor});
  final Color containerColor;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipPath(
                  clipper: MyWaves(),
                  child: Container(
                    color:  containerColor,
                    width: context.getWidth() * 0.3,
                    height: context.getHeight() ,
                    
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

class  MyWaves extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    //  Start point of the wave
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(120, size.height);
    path.quadraticBezierTo(10, size.height - 40, 80, size.height - 180);
    path.quadraticBezierTo(120, size.height - 250, size.width - 5, size.height - 350);
    path.quadraticBezierTo(80, size.height - 450, 40, size.height - 550);
    path.quadraticBezierTo(20, size.height - 600, 40, size.height - 650);
    path.quadraticBezierTo(70, size.height - 720, 15, 0 );
    path.lineTo(20, 0);

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
   

}