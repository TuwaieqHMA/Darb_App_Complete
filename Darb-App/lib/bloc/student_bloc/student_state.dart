part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class StudentLoadingState extends StudentState {

}

final class TripLoadingState extends StudentState {
  
}

final class StudentErrorState extends StudentState {
  final String msg;

  StudentErrorState({required this.msg});
}

final class StudentSignedState extends StudentState {
}

final class StudentNotSignedState extends StudentState {
}

final class LoadedTripsState extends StudentState {
  final TripCard? currentTrip;
  final List<TripCard> tripCardList;

  LoadedTripsState({required this.tripCardList, required this.currentTrip});
}