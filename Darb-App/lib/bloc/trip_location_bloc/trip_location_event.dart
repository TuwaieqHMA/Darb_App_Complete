part of 'trip_location_bloc.dart';

@immutable
sealed class TripLocationEvent {}

final class GetTripDriverCurrentLocationEvent extends TripLocationEvent {
  final String driverId;

  GetTripDriverCurrentLocationEvent({required this.driverId});
}