import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/services/google_maps_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'driver_map_event.dart';
part 'driver_map_state.dart';

class DriverMapBloc extends Bloc<DriverMapEvent, DriverMapState> {
  final homeDataLocator = GetIt.instance.get<HomeData>();
  final serviceLocator = GetIt.instance.get<DBService>();
  final gmLocator = GMService();
  DriverMapBloc() : super(DriverMapInitial()) {
    on<DriverMapEvent>((event, emit) {
      on<GetDriverMapLocationEvent>(getDriverLocation);
    });
  }

  FutureOr<void> getDriverLocation(
      GetDriverMapLocationEvent event, Emitter<DriverMapState> emit) async {
    emit(DriverMapLoadingState());
    try {
      Map<MarkerId, Marker> markers = {};
      Map<PolylineId, Polyline> polyLines = {};
      List<Student> studentsList =
          await serviceLocator.getStudentLocationList(event.tripid);
      Position driverPos = await Geolocator.getCurrentPosition();
      List driverMarker = gmLocator.createMarker(
          id: homeDataLocator.currentUser.id!,
          position: LatLng(driverPos.latitude, driverPos.longitude),
          user: homeDataLocator.currentUser.name,
          color: BitmapDescriptor.defaultMarkerWithHue(5));
      markers[driverMarker[0]] = driverMarker[1];

      List<LatLng> polylineList = await gmLocator.getDirections(
          latStart: driverPos.latitude,
          lngStart: driverPos.longitude,
          latEnd: studentsList[0].latitude!,
          lngEnd: studentsList[0].longitude!);

      final List polylineItem = gmLocator.createPolyLine(
        polylineCoordinates: polylineList,
        id: homeDataLocator.currentUser.id!,
      );
      polyLines[polylineItem[0]] = polylineItem[1];

      for (int i = 0; i < studentsList.length; i++) {
        List studentMarker = gmLocator.createMarker(
            id: studentsList[i].id!,
            position:
                LatLng(studentsList[i].latitude!, studentsList[i].longitude!),
            user: 'الطالب: ${i+1}',
            color: BitmapDescriptor.defaultMarker);
        markers[studentMarker[0]] = studentMarker[1];
        if(i != studentsList.length-1){
          //--------------------------------------------
        List<LatLng> studentPolylineList = await gmLocator.getDirections(
            latStart: studentsList[i].latitude!,
            lngStart: studentsList[i].longitude!,
            latEnd: studentsList[i + 1].latitude!,
            lngEnd: studentsList[i + 1].longitude!);
        //--------------------------------------------
        List studentPolyLine = gmLocator.createPolyLine(
            polylineCoordinates: studentPolylineList, id: studentsList[i].id!);
      
      polyLines[studentPolyLine[0]]= studentPolyLine[1];
        }
      }
  
      emit(DriverMapStudentListState(
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polyLines.values),
          driverLocation: LatLng(driverPos.latitude, driverPos.longitude)));
    } catch (e) {
      emit(DriverMapErrorState('حدثت مشكلة في تنزيل الموقع'));
    }
  }
}
