import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/create_account_type_page.dart';
import 'package:darb_app/pages/Auth%20Pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
      Container(
        alignment: Alignment.bottomCenter,
        width: context.getWidth(),
        height: context.getHeight(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                signatureBlueColor,
                sandYellowColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.65, 1]),
        ),
        child: Image.asset("assets/images/city_landscape.png")
      ),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  const Flexible(
                    child: Text(
                      "مرحباً بك في",
                      style: TextStyle(
                          color: deepBlueColor,
                          fontFamily: "inukFont",
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,),
                          maxLines: 1,
                    ),
                  ),
                  Image.asset("assets/images/darb_text_logo.png"),
                ],
              ),
              SizedBox(
                height: 136,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomButton(
                      onPressed: () {
                        context.push(LoginPage(), false);
                      },
                      text: "تسجيل الدخول",
                    ),
                    BottomButton(
                      onPressed: () {
                        context.push(const CreateAccountTypePage(), true);
                      },
                      text: "إنشاء حساب",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    ]));
  }
}
