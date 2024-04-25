import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/verify_otp_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 42,
        leading: const CircleBackButton(),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/verify_email_vector.png",
            scale: 6,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Center(
                child: Text(
              "إستعادة كلمة المرور",
              style: TextStyle(
                  color: signatureBlueColor,
                  fontFamily: inukFont,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
      bottomSheet: Container(
        width: context.getWidth(),
        height: context.getHeight() * .33,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: signatureBlueColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is EmailVerifiedState) {
              context.showSuccessSnackBar(state.msg);
              context.push(VerifyOtpPage(email: emailController.text,), true);
            }
          },
          builder: (context, state) {
            final authBloc = context.read<AuthBloc>();
            if (state is AuthLoadingState) {
              return SizedBox(
                width: context.getWidth(),
                height: context.getHeight(),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: signatureYellowColor,
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HeaderTextField(
                      controller: emailController,
                      textDirection: TextDirection.ltr,
                      hintText: "الرجاء إدخال بريدك الإلكتروني",
                      headerText: "البريد الإلكتروني"),
                  BottomButton(
                    text: "إستعادة كلمة المرور",
                    onPressed: () {
                      authBloc.add(VerifyEmailEvent(email: emailController.text));
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
