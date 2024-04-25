part of 'driver_bloc.dart';

@immutable
sealed class DriverState {}

final class DriverInitial extends DriverState {}

final class DriverLoadingState extends DriverState{

}

final class DriverErrorState extends DriverState {
  final String msg;

  DriverErrorState({required this.msg});
}

final class DriverLoadedTripsState extends DriverState {
  final TripCard? currentTrip;
  final List<TripCard> tripCardList;

  DriverLoadedTripsState({required this.tripCardList, required this.currentTrip});
}