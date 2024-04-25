import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditStudent extends StatefulWidget {
  const EditStudent({super.key, required this.isView, required this.student});
  final bool isView;
  final DarbUser student;

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
                              widget.isView ? "بيانات الطالب/ة" : "تعديل الطالب/ة",
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
                                hintText: widget.student.name,                                
                                isEnabled: widget.isView ? false : true,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: emailController,
                                headerText: "البريد الالكتروني ",
                                hintText: widget.student.email,
                                isEnabled: false,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: true,
                              ),
                              height16,
                              HeaderTextField(
                                controller: phoneController,
                                headerText: "رقم الجوال",
                                hintText: widget.student.phone,
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
                                      text: "تعديل بيانات الطالب/ة",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogBox(
                                            text:
                                                "هل أنت متأكد من تعديل بيانات الطالب/ة ؟",
                                            onAcceptClick: () {
                                              bloc.add(
                                                UpdateStudent(
                                                    id: widget.student.id!,
                                                    name: nameController
                                                            .text.isEmpty
                                                        ? widget.student.name
                                                        : nameController.text,
                                                    phone: phoneController
                                                            .text.isEmpty
                                                        ? widget.student.phone
                                                        : phoneController.text),
                                              );

                                              context.pop();
                                              context.pop();
                                            },
                                            onRefuseClick: () {
                                              context.pop();
                                            },
                                          ),
                                        );
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
                                      }),
                            ],
                          ),
                          Image.asset(
                            "assets/images/add_student.png",
                            width: context.getWidth(),
                            height: context.getHeight() * .35,
                          ),
                          height8,
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
