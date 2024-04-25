part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class UserSelectedLocationState extends LocationState {
  final String? msg;
  UserSelectedLocationState({this.msg});
}

final class UserNotSelectedLocationState extends LocationState {
  final String msg;
  UserNotSelectedLocationState({required this.msg});
}

final class StudentLoadingState extends LocationState {

}

final class LoadedUserPreviousLocationState extends LocationState {
  final LatLng prevLocation;

  LoadedUserPreviousLocationState({required this.prevLocation});
}

final class StudentErrorState extends LocationState {
  final String msg;

  StudentErrorState({required this.msg});
}