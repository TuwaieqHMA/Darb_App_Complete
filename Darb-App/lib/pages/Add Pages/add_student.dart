import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Button%20Widgets/go_to_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
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
              context.pop();
              context.pop();
              context.showSuccessSnackBar(state.msg);
            }
            if (state is ErrorState) {
              context.showErrorSnackBar(state.msg);
            }
          },
          child: Stack(
            children: [
              WaveDecoration(
                containerColor: signatureBlueColor,
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
                          const Center(
                            child: Text(
                              "إضافة طالب/ة",
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
                                controller: idController,
                                headerText: "رمز الطالب/ة التعريفي",
                                hintText: "أدخل الرمز التعريفي للطالب/ة",
                                headerColor: signatureTealColor,
                                maxLength: 6,
                                textDirection: TextDirection.rtl,
                              ),
                              height32,
                              height8,
                              BottomButton(
                                text: "بحث",
                                textColor: whiteColor,
                                fontSize: 20,
                                onPressed: () {
                                  if (idController.text.length == 6) {
                                    bloc.add(SearchForStudentByIdEvent(
                                        studentId: idController.text));
                                  } else {
                                    context.showErrorSnackBar("الرجاء ملئ الحقل ب 6 رموز ");
                                  }
                                },
                              ),
                              height32,
                              BlocBuilder<SupervisorActionsBloc,
                                  SupervisorActionsState>(
                                builder: (context, state) {
                                  if (state is GetOneStudentState) {
                                    if (state.student.isNotEmpty) {
                                      return Container(
                                        width: context.getWidth(),
                                        height: 52,
                                        padding: const EdgeInsets.all(8),
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: shadowColor,
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset( "assets/icons/circle_person_icon.svg"),
                                            width8,
                                            Expanded(
                                                child: Text(
                                              state.student[0].name,
                                              style: const TextStyle(
                                                color: signatureTealColor,
                                                fontFamily: inukFont,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )),
                                            width8,
                                            GoToButton(
                                              isStudent: true,
                                              text: " إضافة   ",
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DialogBox(
                                                    text: "هل أنت متأكد من إضافة طالب/ة ؟",
                                                    onAcceptClick: () {
                                                      bloc.add(
                                                          AddStudentToSupervisorEvent(student: state.student[0]));
                                                    },
                                                    onRefuseClick: () {
                                                      context.pop();
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const Text(
                                        "لا يوجد طالب/ة بهذا الرمز");
                                  }
                                  return nothing;
                                },
                              )
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
