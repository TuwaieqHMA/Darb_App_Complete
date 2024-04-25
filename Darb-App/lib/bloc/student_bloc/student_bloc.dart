import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/widgets/Card%20Widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final locator = GetIt.I.get<HomeData>();
  final dbService = DBService();
  StudentBloc() : super(StudentInitial()) {
    on<StudentEvent>((event, emit) {});

    on<CheckStudentSignStatusEvent>(checkStudentSignStatus);
    on<GetAllStudentTripsEvent>(getAllStudentTrips);
  }

  FutureOr<void> checkStudentSignStatus(
      CheckStudentSignStatusEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    try {
      final student = await dbService.getStudentInfo();
      if (student.supervisorId != null) {
        emit(StudentSignedState());
        await getAllStudentTrips(GetAllStudentTripsEvent(), emit);
      } else {
        emit(StudentNotSignedState());
      }
    } catch (e) {
      emit(StudentErrorState(msg: "هناك خطأ في تحميل البيانات الخاصة بك"));
    }
  }

  FutureOr<void> getAllStudentTrips(GetAllStudentTripsEvent event, Emitter<StudentState> emit) async{
    emit(TripLoadingState());

    try {
      List<TripCard> tripCardList = await dbService.getAllStudentTrips();
      TripCard? currentTrip;
      TripCard? tripToRemove;
      for(TripCard tripCard in tripCardList){
        if(formatDate(tripCard.trip.date) == formatDate(DateTime.now()) && locator.isGivenTimeInCurrentTime(tripCard.trip.timeFrom, tripCard.trip.timeTo)){
          tripCard.isCurrent = true;
          currentTrip = tripCard;
          tripToRemove = tripCard;
          break;
        }
      }
      tripCardList.removeWhere((element) => element == tripToRemove,);
      emit(LoadedTripsState(tripCardList: tripCardList, currentTrip: currentTrip));
    } catch (e) {
      print(e);
      emit(StudentErrorState(msg: "هناك مشكلة في تحميل الرحلات الخاصة بك"));
    }
  }
}
