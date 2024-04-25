import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/home_appbar.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/Screen%20Widgets/student_id_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentBloc = context.read<StudentBloc>();
    studentBloc.add(CheckStudentSignStatusEvent());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(context.getWidth(), context.getHeight() * .10),
          child: const HomeAppBar(
            backgroundColor: signatureBlueColor,
            textColor: whiteColor,
          )),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentErrorState) {
            context.showErrorSnackBar(state.msg);
          }
        },
        builder: (context, state) {
          if (state is StudentLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: signatureYellowColor,
              ),
            );
          } else if (state is StudentNotSignedState) {
            return const StudentIdWidget();
          } else {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "الرحلة الحالية",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: inukFont,
                    fontSize: 30,
                  ),
                ),
                height24,
                BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    if (state is TripLoadingState) {
                      return const NoItemText(
                        isLoading: true,
                      );
                    } else if (state is LoadedTripsState) {
                      return Column(
                        children: [
                          (state.currentTrip != null)
                              ? state.currentTrip!
                              : const NoItemText(
                                  text: "لا يوجد رحلة حالياً")
                        ],
                      );
                    } else {
                      return const NoItemText(
                        textColor: redColor,
                        text: "هناك خطأ في تحميل الرحلة الحالية",
                      );
                    }
                  },
                ),
                height24,
                const Text(
                  "الرحلات القادمة",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: inukFont,
                    fontSize: 30,
                  ),
                ),
                height24,
                BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    if (state is TripLoadingState) {
                      return const NoItemText(
                        isLoading: true,
                      );
                    } else if (state is LoadedTripsState) {
                      return Column(
                        children: (state.tripCardList.isNotEmpty)
                            ? state.tripCardList
                            : [
                                const NoItemText(
                                  text: "لا يوجد رحلات قادمة",
                                ),
                              ],
                      );
                    } else {
                      return const NoItemText(
                        textColor: redColor,
                        text: "هناك خطأ في تحميل الرحلات القادمة",
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          final studentBloc = context.read<StudentBloc>();
          if (state is TripLoadingState || state is StudentLoadingState || state is StudentNotSignedState) {
            return nothing;
          } else {
            return FloatingActionButton(
              onPressed: () {
                studentBloc.add(GetAllStudentTripsEvent());
              },
              shape: const CircleBorder(),
              backgroundColor: signatureYellowColor,
              child: const Icon(
                Icons.refresh_rounded,
                color: whiteColor,
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
