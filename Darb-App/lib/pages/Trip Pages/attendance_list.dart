import 'package:darb_app/bloc/attendance_list_bloc/attendance_list_bloc.dart';
import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/Map%20Pages/map_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/grid_widget.dart';
import 'package:darb_app/widgets/Card%20Widgets/list_view_bar.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage(
      {super.key,
      required this.trip,
      required this.noOfPassengers,
      this.isCurrent = false});

  final Trip trip;
  final int noOfPassengers;
  final bool? isCurrent;
  @override
  Widget build(BuildContext context) {
    final attendanceListBloc = context.read<AttendanceListBloc>();
    final locator = GetIt.I.get<HomeData>();
    (isCurrent!) ? attendanceListBloc.add(UpdateDriverLocationEvent(trip: trip)) : null;
    attendanceListBloc.add(GetAttendanceListInfoEvent(tripId: trip.id!));
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop && locator.currentUser.userType == "Student") {
          final studentBloc = context.read<StudentBloc>();
          studentBloc.add(GetAllStudentTripsEvent());
        } else if (didPop && locator.currentUser.userType == "Driver") {
          final driverBloc = context.read<DriverBloc>();
          driverBloc.add(GetAllDriverTripsEvent());
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.10),
          child: const PageAppBar(
            title: "بيانات الرحلة",
            backgroundColor: signatureBlueColor,
            textColor: whiteColor,
          ),
        ),
        body: ListView(
          children: [
            BlocConsumer<AttendanceListBloc, AttendanceListState>(
              listener: (context, state) {
                if (state is AttendanceListErrorState) {
                  context.showErrorSnackBar(state.msg);
                }
              },
              builder: (context, state) {
                if (state is RecievedAttendanceListInfoState) {
                  return StreamBuilder<List<AttendanceList>>(
                      stream: state.attendanceList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final attendanceList = snapshot.data;
                          final int presentListLength = attendanceList!
                              .where(
                                (aList) => aList.status == "حاضر",
                              )
                              .length;
                          final int absentListLength = attendanceList
                              .where(
                                (aList) => aList.status == "غائب",
                              )
                              .length;
                          final int waitingListLength = attendanceList
                              .where(
                                (aList) => aList.status == "حضور مؤكد",
                              )
                              .length;
                          return (attendanceList.isNotEmpty)
                              ? SizedBox(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: const EdgeInsets.all(32),
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 30,
                                    crossAxisCount: 2,
                                    children: [
                                      GridContainer(
                                        text: 'الطلاب الحاضرون',
                                        number: presentListLength,
                                        backgroundColor: signatureYellowColor,
                                      ),
                                      GridContainer(
                                        text: 'مجموع الطلاب',
                                        number: attendanceList.length,
                                        backgroundColor: sandYellowColor,
                                      ),
                                      GridContainer(
                                        text: 'الطلاب الغائبون',
                                        number: absentListLength,
                                        backgroundColor: signatureBlueColor,
                                      ),
                                      GridContainer(
                                        text: 'الطلاب في الانتظار',
                                        number: waitingListLength,
                                        backgroundColor: lightsignatureColor,
                                      ),
                                    ],
                                  ),
                                )
                              : const NoItemText(
                                  height: 150,
                                  text: "ليس هناك طلاب في هذه الرحلة",
                                );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const NoItemText(
                            isLoading: true,
                            height: 150,
                          );
                        } else {
                          return const NoItemText(
                            height: 150,
                            text: "ليس هناك أي بيانات متوفرة",
                          );
                        }
                      });
                } else {
                  return const NoItemText(
                    height: 200,
                    text: "جاري تحميل البيانات...",
                  );
                }
              },
            ),
            BlocBuilder<AttendanceListBloc, AttendanceListState>(
              builder: (context, state) {
                if(state is RecievedAttendanceListInfoState){
                  return StreamBuilder<List<AttendanceList>>(
                  stream: state.attendanceList,
                  builder: (context, snapshot) {
                    final attendanceList = snapshot.data;
                    if(snapshot.hasData){
                      attendanceList!.sort((a, b) => a.studentId.compareTo(b.studentId,));
                      state.studentList.sort((a,b) => a.id!.compareTo(b.id!));
                      return (attendanceList.isNotEmpty) ? ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.studentList.length,
                      itemBuilder:(context, index) {
                        AttendanceStatus studentStatus = (attendanceList[index].status == "حضور مؤكد") ? AttendanceStatus.assueredPrecense : (attendanceList[index].status == "حاضر") ? AttendanceStatus.present : AttendanceStatus.absent;
                        return ListViewBar(i: index+1, student: state.studentList[index], status:  studentStatus, trip: trip, isCurrent: isCurrent!,);
                    }
                    ) : nothing;
                    }else if (snapshot.connectionState == ConnectionState.waiting){
                      return nothing;
                    }else {
                      return nothing;
                    }
                  }
                );
                }else {
                  return nothing;
                }
                
              },
            ),
            height50,
          ],
        ),
        bottomSheet: (isCurrent!)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: BottomButton(
                  text: "عرض الخريطة",
                  color: signatureYellowColor,
                  textColor: whiteColor,
                  onPressed: () {
                    context.push(MapPage(trip: trip,), true);
                  },
                ),
              )
            : nothing,
      ),
    );
  }
}
