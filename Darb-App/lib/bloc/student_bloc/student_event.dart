part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class CheckStudentSignStatusEvent extends StudentEvent {

}

final class GetAllStudentTripsEvent extends StudentEvent {
  
}
