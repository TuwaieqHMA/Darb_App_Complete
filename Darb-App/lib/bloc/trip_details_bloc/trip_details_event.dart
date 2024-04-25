part of 'trip_details_bloc.dart';

@immutable
sealed class TripDetailsEvent {}

final class GetDriverInfoEvent extends TripDetailsEvent {
  final String driverId;

  GetDriverInfoEvent({required this.driverId});
}

final class GetCurrentAttendanceStatusEvent extends TripDetailsEvent {
  final int? tripId;

  GetCurrentAttendanceStatusEvent({required this.tripId});
}

final class ChangeAttendanceStatusEvent extends TripDetailsEvent {
  final int? tripId;
  final AttendanceStatus currentStatus;

  ChangeAttendanceStatusEvent({required this.currentStatus, required this.tripId});
}