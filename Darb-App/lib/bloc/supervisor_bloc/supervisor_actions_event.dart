part of 'supervisor_actions_bloc.dart';

@immutable
sealed class SupervisorActionsEvent {}

class ChangeTripTypeEvent extends SupervisorActionsEvent {
  final int num;
  ChangeTripTypeEvent({required this.num});
}

final class SelectDayEvent extends SupervisorActionsEvent {
  final BuildContext context;
  final int num ;
  SelectDayEvent(this.context, this.num);
}

final class SelectStartAndExpireTimeEvent extends SupervisorActionsEvent {
  final BuildContext context;
  final int num ;
  SelectStartAndExpireTimeEvent(this.context, this.num);
}

final class SelectBusDriverEvent extends SupervisorActionsEvent {
  final DarbUser? busDriverId;
  final DarbUser? tripDriverId;
  SelectBusDriverEvent({this.busDriverId, this.tripDriverId});
}

final class GetDriverBusNameEvent extends SupervisorActionsEvent {
  final Bus? busData;
  final Trip? tripData;
  GetDriverBusNameEvent({this.busData, this.tripData});
}

final class GetDriverInfoEvent extends SupervisorActionsEvent {
  final String id;
  GetDriverInfoEvent(this.id);
}


final class SelectTripDriverEvent extends SupervisorActionsEvent {
  final DarbUser driver;
  SelectTripDriverEvent(this.driver);
}

final class RefrshDriverEvent extends SupervisorActionsEvent {
}

final class GetAllSupervisorCurrentTrip extends SupervisorActionsEvent{}
final class GetAllSupervisorFutureTrip extends SupervisorActionsEvent{}
final class GetAllDriver extends SupervisorActionsEvent{}
final class GetAllStudent extends SupervisorActionsEvent{}

final class SearchForStudentByIdEvent extends SupervisorActionsEvent{
  final String studentId;
  SearchForStudentByIdEvent({required this.studentId});
}

final class AddStudentToSupervisorEvent extends SupervisorActionsEvent{
  final DarbUser student;
  AddStudentToSupervisorEvent({required this.student});
}

final class UpdateStudent extends SupervisorActionsEvent{
  final String id;  
  final String name;
  final String phone;
  UpdateStudent({required this.id, required this.name, required this.phone});
}


final class UpdateDriver extends SupervisorActionsEvent{
  final String id;  
  final String name;
  final String phone;
  UpdateDriver({required this.id, required this.name, required this.phone});
}

final class GetAllBus extends SupervisorActionsEvent{}

final class DeleteBus extends SupervisorActionsEvent{
  final String busId;
  final String driverId;
  DeleteBus({ required this.busId, required this.driverId});
}

final class DeleteTrip extends SupervisorActionsEvent{
  final String tripId;
  final Driver driver;
  DeleteTrip({ required this.tripId, required this.driver,});
}

final class DeleteStudent extends SupervisorActionsEvent{
  final String studentId;
  DeleteStudent({ required this.studentId});
}
final class DeleteDriver extends SupervisorActionsEvent{
  final String driverId;
  DeleteDriver({ required this.driverId});
}

final class GetAllDriverHasNotBus extends SupervisorActionsEvent{}
final class GetAllTripDriver extends SupervisorActionsEvent{}


final class AddBusEvent extends SupervisorActionsEvent{
  final Bus bus;
  final String id;
  AddBusEvent({required this.bus, required this.id});
}

final class UpdateBus extends SupervisorActionsEvent{
 final Bus busData;
 UpdateBus({required this.busData,});
}

final class UpdateTrip extends SupervisorActionsEvent{
 final Trip tripData;
 UpdateTrip({required this.tripData,});
}

final class AddTripEvent extends SupervisorActionsEvent{
  final Trip trip;
  final Driver? driver;
  AddTripEvent({required this.trip,  this.driver});
}

//  ------------- Search Event -------------------
final class SearchForStudentEvent extends SupervisorActionsEvent{
  final String studentName;
  SearchForStudentEvent({required this.studentName,});
}
final class SearchForDriverEvent extends SupervisorActionsEvent{
  final String driverName;
  SearchForDriverEvent({required this.driverName,});
}
final class SearchForBusEvent extends SupervisorActionsEvent{
  final int busNumber;
  SearchForBusEvent({required this.busNumber,});
}