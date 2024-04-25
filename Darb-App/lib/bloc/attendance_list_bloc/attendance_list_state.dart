part of 'attendance_list_bloc.dart';

@immutable
sealed class AttendanceListState {}

final class AttendanceListInitial extends AttendanceListState {}

final class AttendanceListLoadingState extends AttendanceListState {

}

final class AttendanceListErrorState extends AttendanceListState {
  final String msg;

  AttendanceListErrorState({required this.msg});
}

final class RecievedAttendanceListInfoState extends AttendanceListState {
  final Stream<List<AttendanceList>> attendanceList;
  final List<DarbUser> studentList;

  RecievedAttendanceListInfoState({required this.attendanceList, required this.studentList});
}