import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Text%20Widgets/two_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountStudentPage extends StatefulWidget {
  const CreateAccountStudentPage({super.key});

  @override
  State<CreateAccountStudentPage> createState() => _CreateAccountStudentPageState();
}

class _CreateAccountStudentPageState extends State<CreateAccountStudentPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/student_vector.png",
                  width:
                      (context.getWidth() < 786) ? context.getWidth() : 786,
                ),
              ),
              const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "إنشاء حساب",
                    style: TextStyle(
                      color: signatureBlueColor,
                      fontFamily: inukFont,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Container(
            width: context.getWidth(),
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 16),
            decoration: const BoxDecoration(
                color: signatureBlueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  context.showErrorSnackBar(state.msg);
                } else if (state is SignedUpState) {
                  context.showSuccessSnackBar(state.msg);
                  context.push(LoginPage(), false);
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
                }
                return Column(
                  children: [
                    HeaderTextField(
                      controller: nameController,
                      hintText: "الاسم الثلاثي",
                      headerText: "الاسم",
                    ),
                    height8,
                    HeaderTextField(
                      controller: phoneController,
                      hintText: "بداية ب 05",
                      headerText: "رقم الجوال",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                    ),
                    height8,
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
                        isObscured: true),
                    height8,
                    HeaderTextField(
                        controller: rePasswordController,
                        hintText: "ادخل كلمة المرور مرة اخرى",
                        headerText: "تأكيد كلمة المرور",
                        isObscured: true),
                    height32,
                    BottomButton(
                      text: "إنشاء الحساب",
                      onPressed: () {
                        authBloc.add(SignUpEvent(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            rePassword: rePasswordController.text,
                            userType: "Student"));
                      },
                    ),
                    height16,
                    TwoTextSpan(
                      normalText: "لديك حساب؟      ",
                      underlinedText: "تسجيل الدخول",
                      onTap: () {
                        context.push(LoginPage(), false);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}





