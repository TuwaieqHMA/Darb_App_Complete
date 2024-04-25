part of 'trip_details_bloc.dart';

@immutable
sealed class TripDetailsState {}

final class TripDetailsInitial extends TripDetailsState {}

final class TripDetailsErrorState extends TripDetailsState {
  final String msg;

  TripDetailsErrorState({required this.msg});
}

final class DriverInfoLoadingState extends TripDetailsState {
}
final class AttendanceStatusLoadingState extends TripDetailsState{

}

final class RecievedTripDriverState extends TripDetailsState{
}

final class RecievedAttendanceStatusState extends TripDetailsState {
  final AttendanceStatus status;
  
  RecievedAttendanceStatusState({required this.status});
}

final class ChangedAttendanceStatusState extends TripDetailsState {
  final String msg;

  ChangedAttendanceStatusState({required this.msg});
}