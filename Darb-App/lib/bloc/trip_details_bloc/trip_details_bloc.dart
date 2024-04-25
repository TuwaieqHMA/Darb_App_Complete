import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  final locator = GetIt.I.get<HomeData>();
  final dbService = DBService();
  TripDetailsBloc() : super(TripDetailsInitial()) {
    on<GetDriverInfoEvent>(getDriverInfo);
    on<GetCurrentAttendanceStatusEvent>(getCurrentAttendanceStatus);
    on<ChangeAttendanceStatusEvent>(changeAttendanceStatus);
  }

  FutureOr<void> getDriverInfo(GetDriverInfoEvent event, Emitter<TripDetailsState> emit) async{
    emit(DriverInfoLoadingState());

    try {
      DarbUser driver = await dbService.getDriverUserInfo(event.driverId);
      locator.currentTripDriver = driver;
      emit(RecievedTripDriverState());
    } catch (e) {
      emit(TripDetailsErrorState(msg: "خطأ في تحميل بيانات السائق"));
    }
  }

  FutureOr<void> getCurrentAttendanceStatus(GetCurrentAttendanceStatusEvent event, Emitter<TripDetailsState> emit) async{
    emit(AttendanceStatusLoadingState());

    try {
      AttendanceList record = await dbService.getStudentAttendanceStatus(event.tripId!);
      emit(RecievedAttendanceStatusState(status: record.status! == "حضور مؤكد" ? AttendanceStatus.assueredPrecense : AttendanceStatus.absent));
    } catch (e) {
      print(e);
      emit(TripDetailsErrorState(msg: "هناك مشكلة في عملية الحصول على حالة حضورك"));
    }
  }

  FutureOr<void> changeAttendanceStatus(ChangeAttendanceStatusEvent event, Emitter<TripDetailsState> emit) async{
    emit(AttendanceStatusLoadingState());

    try {
      AttendanceStatus newStatus = await dbService.changeAttendanceStatus(event.tripId!, event.currentStatus, null);
      emit(ChangedAttendanceStatusState(msg: "تم تغيير حالة حضورك إلى ${newStatus == AttendanceStatus.assueredPrecense ? "حضور مؤكد" : "غائب"}"));
    } catch (e) {
      emit(TripDetailsErrorState(msg: "حدث خطأ في تغيير حالة حضورك"));
    }
  }
}


