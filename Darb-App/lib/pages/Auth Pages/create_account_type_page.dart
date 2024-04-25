import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/create_account_student_page.dart';
import 'package:darb_app/pages/Auth%20Pages/create_account_supervisor_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/container_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAccountTypePage extends StatelessWidget {
  const CreateAccountTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: signatureBlueColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 42,
        leading: const CircleBackButton(),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContainerButton(icon: const FaIcon(FontAwesomeIcons.userTie, color: deepBlueColor, size: 50,), text: "إنشاء حساب كـ مشرف", onTap: () {
                context.push(CreateAccountSupervisorPage(), false);
              },  color: fadedBlueColor, shadowColor: fadedwhiteColor,),
              ContainerButton(icon: const FaIcon(FontAwesomeIcons.userGraduate, color: deepBlueColor, size: 50,), text: "إنشاء حساب كـ طالب/ة", onTap: () {
                context.push(CreateAccountStudentPage(), false);
              },),
            ],
          ),
        ),
      ),
    );
  }
}


