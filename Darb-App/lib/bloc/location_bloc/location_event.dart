part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

final class CheckStudentLocationAvailabilityEvent extends LocationEvent {

}

final class SelectLocationEvent extends LocationEvent {
  final LatLng latLng;
  final bool isEdit;

  SelectLocationEvent({required this.latLng, required this.isEdit});
}

final class GetUserPreviousLocationEvent extends LocationEvent {
  
}