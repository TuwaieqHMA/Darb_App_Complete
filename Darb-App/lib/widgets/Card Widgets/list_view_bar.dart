import 'package:darb_app/bloc/attendance_list_bloc/attendance_list_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/Trip%20Pages/chat_view.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/atttendanceWidget.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ListViewBar extends StatelessWidget {
  const ListViewBar({super.key, required this.i, required this.student, required this.status, this.isCurrent = false, required this.trip});

  final int i;
  final Trip trip;
  final DarbUser student;
  final AttendanceStatus status;
  final bool? isCurrent;

  @override
  Widget build(BuildContext context) {
    final attendanceListBloc = context.read<AttendanceListBloc>();
    final locator = GetIt.I.get<HomeData>();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: i.isEven ? lightyellowColor : whiteColor,
        border: const Border(
            bottom: BorderSide(color: signatureTealColor, width: 2)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '$i  - ${student.name}',
                style: const TextStyle(
                  color: signatureTealColor,
                  fontFamily: inukFont,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                      context.push(ChatView(studentId: student.id!, driverId: locator.currentUser.id!,), true);
                    
                  },
                  child: (isCurrent!) ? Image.asset(
                    "assets/icons/Messaging.png",
                  ) : nothing,
                ),
                width12,
                PresenceStatusButton(status: status, onTap: (isCurrent! && status == AttendanceStatus.assueredPrecense) ? () {
                  showDialog(context: context, builder: (context) {
                    return DialogBox(
                      text: "هل ${student.name} حاضر/ة أم غائب/ة؟",
                      acceptText: "حاضر/ة",
                      refuseText: "غائب/ة",
                      hasExitButton: true,
                      onAcceptClick: () {
                        showDialog(context: context, builder: (context) {
                          return DialogBox(text: "هل أنت متأكد من تغيير حالة الطالب/ة لحاضر؟\nلا يمكن تغيير الحالة بعد ذلك",
                          onAcceptClick: () {
                            attendanceListBloc.add(ChangeStudentAttendanceStatusEvent(tripId: trip.id!, currentStatus: AttendanceStatus.present, studentId: student.id!));
                            context.pop();
                            context.pop();
                          },
                          onRefuseClick: () {
                            context.pop();
                          },
                          );
                        },);
                      },
                      onRefuseClick: () {
                        showDialog(context: context, builder: (context) {
                          return DialogBox(text: "هل أنت متأكد من تغيير حالة الطالب/ة لغائب؟\nلا يمكن تغيير الحالة بعد ذلك",
                          onAcceptClick: () {
                            attendanceListBloc.add(ChangeStudentAttendanceStatusEvent(tripId: trip.id!, currentStatus: AttendanceStatus.absent, studentId: student.id!));
                            context.pop();
                            context.pop();
                          },
                          onRefuseClick: () {
                            context.pop();
                          },
                          );
                        },);
                      },
                    );
                  },);
                } : null)
              ],
            ),
          ],
        ),
      ),
    );
  }
}