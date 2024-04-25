part of 'permission_bloc.dart';

@immutable
sealed class PermissionState {}

final class PermissionInitial extends PermissionState {}

final class LocationPermissionGrantedState extends PermissionState {
  final String msg;

  LocationPermissionGrantedState({required this.msg});
}

final class LocationPermissionPreviouslyGrantedState extends PermissionState {
}

final class LocationPermissionDeniedState extends PermissionState {
  final String msg;

  LocationPermissionDeniedState({required this.msg});
}

final class RequestAppSettingsState extends PermissionState {

}

final class PermissionLoadingState extends PermissionState {

}