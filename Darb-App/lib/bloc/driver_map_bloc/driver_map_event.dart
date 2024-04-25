part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapEvent {}

final class GetDriverMapLocationEvent extends DriverMapEvent{
 final int tripid;

  GetDriverMapLocationEvent({required this.tripid});
}

final class AddMarkerEvent extends DriverMapEvent{

}

final class GetDirectionsEvent extends DriverMapEvent{}