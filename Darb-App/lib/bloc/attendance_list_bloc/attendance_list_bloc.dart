import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'attendance_list_event.dart';
part 'attendance_list_state.dart';

class AttendanceListBloc
    extends Bloc<AttendanceListEvent, AttendanceListState> {
  final dbServiceLocator = GetIt.I.get<DBService>();
  AttendanceListBloc() : super(AttendanceListInitial()) {
    on<GetAttendanceListInfoEvent>(getAttendanceInfoEvent);
    on<ChangeStudentAttendanceStatusEvent>(changeStudentAttendanceStatus);
    on<UpdateDriverLocationEvent>(updateLocationDriver);
  }

  FutureOr<void> getAttendanceInfoEvent(GetAttendanceListInfoEvent event,
      Emitter<AttendanceListState> emit) async {
    emit(AttendanceListLoadingState());

    try {
      final List<DarbUser> studentList =
          await dbServiceLocator.getTripStudentList(event.tripId);
      Stream<List<AttendanceList>> attendanceList =
          dbServiceLocator.getAttendanceList(event.tripId);
      emit(RecievedAttendanceListInfoState(
          attendanceList: attendanceList, studentList: studentList));
    } catch (e) {
      print(e);
      emit(AttendanceListErrorState(
          msg: "هناك مشكلة في الحصول على بيانات الرحلة"));
    }
  }

  FutureOr<void> changeStudentAttendanceStatus(
      ChangeStudentAttendanceStatusEvent event,
      Emitter<AttendanceListState> emit) async {
    try {
      await dbServiceLocator.changeAttendanceStatus(
          event.tripId, event.currentStatus, event.studentId);
    } catch (e) {
      emit(AttendanceListErrorState(msg: "هناك خطأ في تحديث بيانات الطالب/ة"));
    }
  }

  FutureOr<void> updateLocationDriver(UpdateDriverLocationEvent event,
      Emitter<AttendanceListState> emit) async {
    try {
      await dbServiceLocator.checkDriverLocationExist();
      print("checked location");
      await dbServiceLocator.createDriverLocationCron(event.trip.timeFrom, event.trip.timeTo, event.trip.driverId);
      print("updated cron");
    } catch (e) {
      print(e);
      emit(AttendanceListErrorState(msg: "هناك خطأ في تحديث الموقع الخاص بك"));
    }
  }
}
