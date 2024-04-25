part of 'attendance_list_bloc.dart';

@immutable
sealed class AttendanceListEvent {}

final class GetAttendanceListInfoEvent extends AttendanceListEvent {
  final int tripId;

  GetAttendanceListInfoEvent({required this.tripId});
}

final class ChangeStudentAttendanceStatusEvent extends AttendanceListEvent {
  final int tripId;
  final AttendanceStatus currentStatus;
  final String studentId;

  ChangeStudentAttendanceStatusEvent({required this.tripId, required this.currentStatus, required this.studentId});
}

final class UpdateDriverLocationEvent extends AttendanceListEvent {
  final Trip trip;

  UpdateDriverLocationEvent({required this.trip});
}