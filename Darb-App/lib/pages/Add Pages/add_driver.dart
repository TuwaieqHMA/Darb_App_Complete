import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            WaveDecoration(
              containerColor: signatureBlueColor,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SignedUpState){
                  context.showSuccessSnackBar(state.msg);
                  context.pop();
                  context.pop();
                }else if (state is AuthErrorState){
                  context.showErrorSnackBar(state.msg);
                }
              },
              builder: (context, state) {
                final authBloc = context.read<AuthBloc>();
                if (state is AuthLoadingState){
                  return const Center(child: CircularProgressIndicator(color: signatureYellowColor,),);
                }
                return ListView(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height24,
                        CircleBackButton(),
                      ],
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: context.getWidth() * 0.85,
                        child: Column(
                          children: [
                            height24,
                            const Center(
                              child: Text(
                                "إضافة سائق",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: blueColor),
                              ),
                            ),
                            Column(
                              children: [
                                height32,
                                HeaderTextField(
                                  controller: nameController,
                                  headerText: "الاسم",
                                  hintText: "الاسم الثلاثي",
                                  headerColor: signatureTealColor,
                                ),
                                height16,
                                HeaderTextField(
                                  controller: emailController,
                                  headerText: "البريد الالكتروني ",
                                  hintText: "someone@email.com",
                                  headerColor: signatureTealColor,
                                  textDirection: TextDirection.ltr,
                                ),
                                height16,
                                HeaderTextField(
                                  controller: phoneController,
                                  headerText: "رقم الجوال",
                                  hintText: "مبتدأً ب 05",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.phone,
                                  headerColor: signatureTealColor,
                                  textDirection: TextDirection.ltr,
                                ),
                                height16,
                                HeaderTextField(
                                  controller: passwordController,
                                  headerText: "كلمة السر",
                                  hintText: "ادخل كلمة السر",
                                  headerColor: signatureTealColor,
                                  isObscured: true,
                                ),
                                height16,
                                HeaderTextField(
                                  controller: rePasswordController,
                                  headerText: "كلمة السر مجدداً",
                                  hintText: "ادخل كلمة السر مجدداً",
                                  headerColor: signatureTealColor,
                                  isObscured: true,
                                ),
                                height32,
                                height8,
                                BottomButton(
                                  text: "إضافة",
                                  textColor: whiteColor,
                                  fontSize: 20,
                                  onPressed: () {
                                    authBloc.add(SignUpEvent(name: nameController.text, email: emailController.text, phone: phoneController.text, password: passwordController.text, rePassword: rePasswordController.text, userType: "Driver"));
                                  },
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/add_driver_img.png",
                              width: context.getWidth(),
                              height: context.getHeight() * .35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
