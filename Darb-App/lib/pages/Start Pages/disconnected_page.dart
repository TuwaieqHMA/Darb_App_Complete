import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DisconnectedPage extends StatelessWidget {
  const DisconnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Directionality(
      textDirection: locator.currentDirctionallity,
      child: Scaffold(
        backgroundColor: offWhiteColor,
        body: Padding(padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_connection.png", width: context.getWidth(),),
            height16,
            const Text("لا يوجد إتصال بالإنترنت!", style: TextStyle(color: signatureBlueColor, fontFamily: inukFont, fontSize: 24, fontWeight: FontWeight.bold),)
          ],
        ),),
      ),
    );
  }
}