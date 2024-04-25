part of 'trip_location_bloc.dart';

@immutable
sealed class TripLocationState {}

final class TripLocationInitial extends TripLocationState {}

final class TripLocationLoadingState extends TripLocationState {

}

final class TripLocationSuccessState extends TripLocationState {
  final String msg;

  TripLocationSuccessState({required this.msg});
}

final class TripLocationErrorState extends TripLocationState {
  final String msg;

  TripLocationErrorState({required this.msg});
}

final class TripDriverLocationRecieved extends TripLocationState {
  final Stream<List<Location>> driverLocation;
  final List<LatLng> polyLineCoordinates;
  final Student student;

  TripDriverLocationRecieved({required this.driverLocation, required this.student, required this.polyLineCoordinates});
}