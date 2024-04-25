import 'package:darb_app/utils/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMService {
  List createMarker(
      {required String id,
      required LatLng position,
      required String user,
      required BitmapDescriptor color}) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      //add start location marker
      markerId: markerId,
      //position of marker
      position: position,
      //popup info
      infoWindow: InfoWindow(
        title: user,
      ),
      icon: color, //Icon for Marker
    );
    return [markerId, marker];
  }

  Future<List<LatLng>> getDirections({
    required double latStart,
    required double lngStart,
    required double latEnd,
    required double lngEnd,
  }) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['googleCloudKey']!,
      PointLatLng(latStart, lngStart),
      PointLatLng(latEnd, lngEnd),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  List createPolyLine({required List<LatLng> polylineCoordinates,required String id}) {
    PolylineId polyLineid = PolylineId(id);
    Polyline polyline = Polyline(
      polylineId: polyLineid,
      color: lightSeaSaltBlue,
      points: polylineCoordinates,
      width: 8,
    );
    List polylineItems = [polyLineid, polyline];
    return polylineItems;
  }
}
