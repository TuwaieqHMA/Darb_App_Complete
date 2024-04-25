import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<CheckLocationPermissionEvent>(checkLocationPermission);
    on<RequestNormalOrSettingsEvent>(requestNormalOrSettings);
  }

  FutureOr<void> checkLocationPermission(CheckLocationPermissionEvent event, Emitter<PermissionState> emit) async{
    emit(PermissionLoadingState());
    if (await Permission.location.isGranted){
      emit(LocationPermissionPreviouslyGrantedState());
      emit(PermissionLoadingState());
    }else if(await Permission.location.isDenied){
      final status = await Permission.location.request();
      if(status.isGranted){
        emit(LocationPermissionGrantedState(msg: "تم السماح بالوصول للموقع، شكراً لك"));
      }else {
        emit(LocationPermissionDeniedState(msg: "تم رفض الوصول للموقع، الرجاء قبول الوصول لتتمكن من إستخدام خدمات التطبيق"));
      }
    }else {
      emit(LocationPermissionDeniedState(msg: "تم رفض الوصول للموقع نهائياً، الرجاء تفعيل الموقع عن طريق إعدادات التطبيق"));
    }
  }

  FutureOr<void> requestNormalOrSettings(RequestNormalOrSettingsEvent event, Emitter<PermissionState> emit) async{
    emit(PermissionLoadingState());

    if(await Permission.location.isPermanentlyDenied){
      emit(RequestAppSettingsState());
    }else {
      final status = await Permission.location.request();
      if(status.isGranted){
        emit(LocationPermissionGrantedState(msg: "تم السماح بالوصول للموقع، شكراً لك"));
      }else {
        emit(LocationPermissionDeniedState(msg: "تم رفض الوصول للموقع، الرجاء قبول الوصول لتتمكن من إستخدام خدمات التطبيق"));
      }
    }
  }
}
