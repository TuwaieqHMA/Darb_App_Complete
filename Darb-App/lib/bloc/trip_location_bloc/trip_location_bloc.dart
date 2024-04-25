import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/services/google_maps_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'trip_location_event.dart';
part 'trip_location_state.dart';

class TripLocationBloc extends Bloc<TripLocationEvent, TripLocationState> {
  final dbService = GetIt.I.get<DBService>();
  final gmService = GMService();
  TripLocationBloc() : super(TripLocationInitial()) {
    on<TripLocationEvent>((event, emit) {});

    on<GetTripDriverCurrentLocationEvent>(getDriverCurrentLocation);
  }

  FutureOr<void> getDriverCurrentLocation(
      GetTripDriverCurrentLocationEvent event,
      Emitter<TripLocationState> emit) async {
    emit(TripLocationLoadingState());

    try {
      List<LatLng> polyLineStudentDriverCoordanitesList = [];
      Student student = await dbService.getStudentHomeLocation();
      Stream<List<Location>> driverLoactionStream =
          dbService.getTripCurrentDriverLocation(event.driverId);
          driverLoactionStream.listen(
            (location) async{
                Location driverLocation = location[0];
                polyLineStudentDriverCoordanitesList = await gmService.getDirections(latStart: driverLocation.latitude, lngStart: driverLocation.longitude, latEnd: student.latitude!, lngEnd: student.longitude!);
            }, 
          );
          await Future.delayed(const Duration(seconds: 1));
          emit(TripDriverLocationRecieved(driverLocation: driverLoactionStream, student: student, polyLineCoordinates: polyLineStudentDriverCoordanitesList));
    } catch (e) {
      print(e);
      emit(TripLocationErrorState(msg: "هناك خطأ في تحميل بيانات السائق"));
    }
  }
}
