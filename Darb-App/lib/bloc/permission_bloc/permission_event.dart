part of 'permission_bloc.dart';

@immutable
sealed class PermissionEvent {}

final class CheckLocationPermissionEvent extends PermissionEvent {

}

final class RequestNormalOrSettingsEvent extends PermissionEvent {
  
}