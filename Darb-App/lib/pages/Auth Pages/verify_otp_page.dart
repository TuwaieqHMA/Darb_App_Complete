import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/change_password_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    String otpText = "";
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 42,
        leading: const CircleBackButton(),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpVerifiedState) {
            context.showSuccessSnackBar(state.msg);
            context.push(ChangePasswordPage(), true);
          } else if (state is OtpResentState) {
            context.showSuccessSnackBar(state.msg);
          }
        },
        builder: (context, state) {
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  Image.asset(
                    "assets/images/enter_otp_vector.png",
                  ),
                  const Center(
                      child: Text(
                    "التحقق من بريدك الإلكتروني",
                    style: TextStyle(
                        color: signatureBlueColor,
                        fontFamily: inukFont,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  )),
                  const Center(
                      child: Text(
                    "الرجاء إدخال الرمز المرسل إلى بريدك الإلكتروني",
                    style: TextStyle(
                      color: signatureBlueColor,
                      fontFamily: inukFont,
                      fontSize: 18,
                    ),
                  )),
                  height16,
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      borderColor: signatureBlueColor,
                      borderRadius: BorderRadius.circular(12),
                      cursorColor: signatureBlueColor,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      showFieldAsBox: true,
                      borderWidth: 2,
                      fieldWidth: context.getWidth() * .12,
                      fieldHeight: context.getWidth() * .15,
                      numberOfFields: 6,
                      onSubmit: (otp) {
                        authBloc.add(VerifyOtpEvent(otp: otp, email: email));
                      },
                      onCodeChanged: (value) {
                        otpText = value;
                      },
                    ),
                  ),
                  height16,
                  OtpTimerButton(
                    onPressed: () {
                      authBloc.add(ResendOtpEvent(email: email));
                    },
                    text: const Text("إعادة إرسال الرمز"),
                    duration: 60,
                    backgroundColor: signatureBlueColor,
                    textColor: whiteColor,
                  ),
                  height16,
                  BottomButton(
                    text: "التحقق",
                    onPressed: () {
                      authBloc.add(VerifyOtpEvent(otp: otpText, email: email));
                    },
                  ),
                  height16, 
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
