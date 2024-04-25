import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final dbService = DBService();
  LocationBloc() : super(LocationInitial()) {
    on<CheckStudentLocationAvailabilityEvent>(checkStudentLocationAvailability);
    on<SelectLocationEvent>(selectLocation);
    on<GetUserPreviousLocationEvent>(getUserPreviousLocation);
  }

  FutureOr<void> checkStudentLocationAvailability(CheckStudentLocationAvailabilityEvent event, Emitter<LocationState> emit) async{
    emit(StudentLoadingState());
    
    try {
      Student student = await dbService.getStudentInfo();

      if(student.latitude != null && student.longitude != null){
        emit(UserSelectedLocationState());
      }else {
        emit(UserNotSelectedLocationState(msg: "الرجاء تحديد الموقع الخاص بمنزلك"));
      }
    } catch (e) {
      emit(StudentErrorState(msg: "هناك خطأ في الشبكة، يرجى المحاولة لاحقاً"));
    }
  }

  FutureOr<void> selectLocation(SelectLocationEvent event, Emitter<LocationState> emit) async{
    emit(StudentLoadingState());
    Student student = await dbService.getStudentInfo();
    if(student.latitude != event.latLng.latitude && student.longitude != event.latLng.longitude){
      try {
      await dbService.updateUserLocation(event.latLng);
      emit(UserSelectedLocationState(msg: (event.isEdit) ? "تم تحديث الموقع الخاص بك، شكراً لك" : "تم إختيار الموقع الخاص بمنزلك، شكراً لك"));
    } catch (e) {
      emit(StudentErrorState(msg: "هناك مشكلة في عملية تحديث الموقع"));
    }
    }else {
      emit(StudentErrorState(msg: "الموقع المختار نفس الموقع السابق"));
    }
    
  }

  FutureOr<void> getUserPreviousLocation(GetUserPreviousLocationEvent event, Emitter<LocationState> emit) async{
    emit(StudentLoadingState());

    Student student = await dbService.getStudentInfo();

    if(student.latitude != null && student.longitude != null){
      emit(LoadedUserPreviousLocationState(prevLocation: LatLng(student.latitude!, student.longitude!)));
    }else {
      emit(StudentErrorState(msg: "هناك مشكلة في تحميل موقعك السابق"));
    }
  }
}
