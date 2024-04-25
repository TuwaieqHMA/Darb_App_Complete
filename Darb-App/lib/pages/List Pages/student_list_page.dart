import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Edit%20Pages/edit_student.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Text%20Widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:darb_app/widgets/Card%20Widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllStudent());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .21),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة الطلاب",
          bottom: PreferredSize(
            preferredSize: Size(context.getWidth(), 72),
            child: Container(
              width: context.getWidth(),
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                  color: offWhiteColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 4))
                  ]),
              child: CustomSearchBar(
                controller: searchController,
                hintText: "ابحث عن طالب/ة...",
                onChanged: (value) {
                  if(value.isEmpty){
                  bloc.add(GetAllStudent());
                  }
                },
                onEditingComplete: () {
                  bloc.add(SearchForStudentEvent(studentName: searchController.text));
                },
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
        listener: (context, state) {
          if (state is SuccessfulState) {
            context.showSuccessSnackBar(state.msg);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          children: [
            BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                builder: (context, state) {
              if (state is LoadingState) {
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
              if(state is SearchForStudentState){
                if(state.student.isNotEmpty){
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.student.length,
                      itemBuilder: (context, index) {
                        return PersonCard(
                          user: state.student[index],
                          name: state.student[index].name, 
                          onView: () {
                            context.push( EditStudent(isView: true, student: state.student[index], ), true);
                          },
                          onEdit: () {
                            context.push( EditStudent(isView: false, student: locator.students[index],), true);
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                text: "هل أنت متأكد من حذف الطالب/ة ؟",
                                onAcceptClick: () {
                                  bloc.add(DeleteStudent(
                                      studentId: locator.students[index].id
                                          .toString()));
                                  context.pop();
                                },
                                onRefuseClick: () {
                                  context.pop();
                                },
                              ),
                            );
                          },
                        );
                      });
                } return const Center(child: Text("لا توجد نتائج .."));
              }
              if (state is GetAllStudentState) {
                if (state.student.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.student.length,
                      itemBuilder: (context, index) {
                        return PersonCard(
                          user: state.student[index],
                          name: state.student[index].name, 
                          onView: () {
                            context.push( EditStudent(isView: true, student: locator.students[index], ), true);
                          },
                          onEdit: () {
                            context.push( EditStudent(isView: false, student: locator.students[index],), true);
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                text: "هل أنت متأكد من حذف الطالب/ة ؟",
                                onAcceptClick: () {
                                  bloc.add(DeleteStudent(
                                      studentId: locator.students[index].id
                                          .toString()));
                                  context.pop();
                                },
                                onRefuseClick: () {
                                  context.pop();
                                },
                              ),
                            );
                          },
                        );
                      });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    height32,
                    Image.asset("assets/images/empty_student.png"),
                    height16,
                    const Text(
                      "لا يوجد طلاب مضافين حالياً",
                      style: TextStyle(fontSize: 16, color: signatureBlueColor),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
