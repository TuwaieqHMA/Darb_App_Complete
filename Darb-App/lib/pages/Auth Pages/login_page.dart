import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/create_account_type_page.dart';
import 'package:darb_app/pages/Auth%20Pages/verify_email_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Redirection%20Widgets/redirect_widget.dart';
import 'package:darb_app/widgets/Text%20Widgets/two_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.getWidth(),
            height: context.getHeight(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: context.getWidth(),
                    height: context.getHeight() * .7,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 46, bottom: 16),
                    decoration: const BoxDecoration(
                        color: signatureBlueColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthErrorState){
                          context.showErrorSnackBar(state.msg);
                        } else if (state is LoggedInState){
                          context.showSuccessSnackBar(state.msg);
                          context.push(const RedirectWidget(), false);
                        }
                      },
                      builder: (context, state) {
                        final authBloc = context.read<AuthBloc>();
                        if (state is AuthLoadingState){
                          return SizedBox(
                            width: context.getWidth(),
                            height: context.getHeight(),
                            child: const Center(child: CircularProgressIndicator(color: signatureYellowColor,),),
                          );
                        }else {
                        return Column(
                          children: [
                            HeaderTextField(
                              controller: emailController,
                              hintText: "someone@email.com",
                              hintTextDircetion: TextDirection.ltr,
                              headerText: "البريد الالكتروني",
                              textDirection: TextDirection.ltr,
                            ),
                            height8,
                            HeaderTextField(
                              controller: passwordController,
                              hintText: "ادخل كلمة المرور الخاصة بك",
                              headerText: "كلمة المرور",
                              isObscured: true,
                            ),
                            height8,
                            Align(
                              alignment: Alignment.centerRight,
                              child: TwoTextSpan(
                                normalText: "",
                                underlinedText: "نسيت كلمة المرور؟",
                                onTap: () {
                                  context.push(VerifyEmailPage(), true);
                                },
                              ),
                            ),
                            height32,
                            BottomButton(
                              text: "تسجيل الدخول",
                              onPressed: () {
                                authBloc.add(LoginEvent(email: emailController.text, password: passwordController.text));
                              },
                            ),
                            height16,
                            TwoTextSpan(
                              normalText: "ليس لديك حساب؟      ",
                              underlinedText: "إنشاء حساب",
                              onTap: () {
                                context.push(
                                    const CreateAccountTypePage(), true);
                              },
                            )
                          ],
                        );
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/bus_vector.png",
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: signatureBlueColor,
                      fontFamily: inukFont,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
