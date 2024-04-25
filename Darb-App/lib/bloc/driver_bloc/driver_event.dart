part of 'driver_bloc.dart';

@immutable
sealed class DriverEvent {}

final class GetAllDriverTripsEvent extends DriverEvent {
  
}