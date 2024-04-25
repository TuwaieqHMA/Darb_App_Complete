import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/Button Widgets/circle_back_button.dart';

class EditDriver extends StatefulWidget {
  const EditDriver({super.key, required this.isView, required this.driver});
  final bool isView;
  final DarbUser driver;

  @override
  State<EditDriver> createState() => _EditDriverState();
}

class _EditDriverState extends State<EditDriver> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
          listener: (context, state) {
            if (state is SuccessfulState) {
              context.showSuccessSnackBar(state.msg);
            }
          },
          child: Stack(
            children: [
              WaveDecoration(
                containerColor: lightGreenColor,
              ),
              ListView(
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
                          Center(
                            child: Text(
                              widget.isView ? "بيانات السائق" : "تعديل السائق",
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: lightGreenColor),
                            ),
                          ),
                          Column(
                            children: [
                              height32,
                              HeaderTextField(
                                controller: nameController,
                                headerText: "الاسم",
                                hintText: widget.driver.name,
                                isEnabled: widget.isView ? false : true,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: emailController,
                                headerText: "البريد الالكتروني ",
                                hintText: widget.driver.email,
                                isEnabled:  false,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: phoneController,
                                headerText: "الجوال",
                                hintText: widget.driver.phone,
                                isEnabled: widget.isView ? false : true,
                                keyboardType: TextInputType.phone,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height32,
                              height8,
                              widget.isView
                                  ? const SizedBox.shrink()
                                  : BottomButton(
                                      text: "تعديل بيانات السائق",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      onPressed: () {
                                  
                                          showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                    text:"هل أنت متأكد من تعديل بيانات السائق ؟",
                                                    onAcceptClick: () {
                                                      bloc.add(UpdateDriver(
                                                        id: widget.driver.id!, 
                                                        name: nameController.text.isEmpty ? widget.driver.name : nameController.text, 
                                                        phone: phoneController.text.isEmpty ? widget.driver.phone : phoneController.text));
                                                      
                                                      context.pop();
                                                      context.pop();
                                                      
                                                    },
                                                    onRefuseClick: () {
                                                      context.pop();
                                                    },
                                                  ));
                                      
                                      },
                                    ),
                              widget.isView ? const SizedBox.shrink() : height24,
                              widget.isView
                                  ? const SizedBox.shrink()
                                  : BottomButton(
                                      text: "إلغاء",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      color: signatureBlueColor,
                                      onPressed: () {
                                        context.pop();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
