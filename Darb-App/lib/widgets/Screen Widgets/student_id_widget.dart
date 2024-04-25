import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StudentIdWidget extends StatelessWidget {
  const StudentIdWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset("assets/images/waiting.png", width: context.getWidth(),),
          height16,
          const Text("أنت غير مسجل لدى مشرف، يرجى مشاركة رمزك الخاص مع المشرف ليتم تسجيلك", style: TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 24, ), textAlign: TextAlign.center,),
          const Text("هذا الرمز خاص، لا تشاركه الا مع المشرف الخاص بك", style: TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 16,), textAlign: TextAlign.center),
          Text("رمزك الخاص هو: ${locator.currentUser.id!.substring(30, 36)}", style: const TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 24, fontWeight: FontWeight.bold),),
    
      
        ],
      ),
    );
  }
}