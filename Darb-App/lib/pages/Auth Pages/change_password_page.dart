import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 42,
        leading: CircleBackButton(
          onTap: () {
            authBloc.add(SignOutEvent());
            context.pop();
          },
        ),
      ),
      body: SizedBox(
        width: context.getWidth(),
        height: context.getHeight() * 0.5,
        child: ListView(
          children: [
            Image.asset(
              "assets/images/reset_password_vector.png",
              height: 300,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Center(
                  child: Text(
                "تغيير كلمة المرور",
                style: TextStyle(
                    color: signatureBlueColor,
                    fontFamily: inukFont,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ]
        ),
      ),
        
      bottomSheet:
       Container(
        width: context.getWidth(),
        height: context.getHeight() * .45,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: signatureBlueColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is PasswordChangedState) {
              context.showSuccessSnackBar(state.msg);
              context.push(LoginPage(), false);
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HeaderTextField(
                    isObscured: true,
                      controller: passwordController,
                      headerText: "كلمة المرور الجديدة"),
                  HeaderTextField(
                    isObscured: true,
                      controller: rePasswordController,
                      headerText: "إعادة كلمة المرور الجديدة"),
                  BottomButton(
                    text: "تغيير كلمة المرور",
                    onPressed: () {
                      authBloc.add(ChangePasswordEvent(
                          password: passwordController.text,
                          rePassword: rePasswordController.text));
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
