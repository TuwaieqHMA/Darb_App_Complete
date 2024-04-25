part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapState {}

final class DriverMapInitial extends DriverMapState {}

final class DriverMapLoadingState extends DriverMapState {}

final class DriverMapErrorState extends DriverMapState {
  final String msg;

  DriverMapErrorState( this.msg);
}

final class DriverMapStudentListState extends DriverMapState {
 final Set<Marker> markers;
 final Set<Polyline> polylines;
 final LatLng driverLocation;

  DriverMapStudentListState({required this.markers, required this.polylines, required this.driverLocation});
}

final class DriverMapPolylineState extends DriverMapState{
  final List polylineItems;

  DriverMapPolylineState({required this.polylineItems});
}