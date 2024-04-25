import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/pages/Trip%20Pages/chat_view.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Text%20Widgets/icon_text_bar.dart';
import 'package:darb_app/widgets/Text%20Widgets/svg_text_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DriverInfoCard extends StatelessWidget {
  const DriverInfoCard({
    super.key,
    required this.isCurrent, required this.driver,
  });

  final DarbUser driver;
  final bool? isCurrent;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Container(
        height: context.getWidth() * 0.360,
        width: context.getWidth(),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgTextBar(text: driver.name, svgUrl: "assets/icons/circle_person_icon.svg", textColor: blueColor,),
            IconTextBar(text: driver.phone, icon: Icons.phone, iconColor: blueColor, fontSize: 14, textColor: blueColor,),
            InkWell(
              onTap: () {
                if(isCurrent!){
                  context.push(ChatView(driverId: driver.id!, studentId: locator.currentUser.id!,), true);
                }
              },
              child: IconTextBar(text: (isCurrent!) ? "التحدث مع السائق" : "غير متاح", icon: Icons.chat_bubble_rounded, iconColor: blueColor, direction: TextDirection.ltr, textDecoration: (isCurrent!) ? TextDecoration.underline : null, textColor: (isCurrent!) ? blueColor : redColor,)),
    
          ],
        )
        );
  }
}