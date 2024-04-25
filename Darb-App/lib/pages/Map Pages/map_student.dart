import 'package:darb_app/bloc/trip_location_bloc/trip_location_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStudent extends StatefulWidget {
  const MapStudent({super.key, required this.driverId});

  final String driverId;

  @override
  State<MapStudent> createState() => _MapPageState();
}

class _MapPageState extends State<MapStudent> {

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    final tripLocationBloc = context.read<TripLocationBloc>();
    tripLocationBloc
        .add(GetTripDriverCurrentLocationEvent(driverId: widget.driverId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.10),
        child: const PageAppBar(
          title: "الخريطة",
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
        ),
      ),
      body: BlocBuilder<TripLocationBloc, TripLocationState>(
        builder: (context, state) {
          if (state is TripLocationLoadingState) {
            return NoItemText(
              isLoading: true,
              height: context.getHeight(),
            );
          } else if (state is TripDriverLocationRecieved) {
            return StreamBuilder<List<Location>>(
                stream: state.driverLocation,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Location> driverLoaction = snapshot.data!;
                    if (driverLoaction.isNotEmpty) {
                      Location driverLocation = snapshot.data![0];
                      markers.add(Marker(markerId: MarkerId(driverLocation.userId),
                      position: LatLng(driverLocation.latitude, driverLocation.longitude),
                      infoWindow: const InfoWindow(title: 'موقع السائق'),
                      icon: BitmapDescriptor.defaultMarker));
                      markers.add(Marker(markerId: MarkerId(state.student.id!),
                      position: LatLng(state.student.latitude!, state.student.longitude!),
                      infoWindow: const InfoWindow(title: 'موقعك المختار'),
                      icon: BitmapDescriptor.defaultMarker));
                      polylines.add(Polyline(polylineId: PolylineId(driverLocation.userId),
                      points: state.polyLineCoordinates,
                      color: lightSeaSaltBlue,
                      width: 8));
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(state.student.latitude!, state.student.longitude!),
                          zoom: 14.0,
                        ),
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          setState(() {});
                        },
                        markers: markers,
                        polylines: polylines,
                        myLocationEnabled: true,
                      );
                    } else {
                      return NoItemText(
                        text: "موقع السائق غير متوفر حالياً",
                        height: context.getHeight() * .9,
                      );
                    }
                  } else {
                    return NoItemText(
                      isLoading: true,
                      height: context.getHeight(),
                    );
                  }
                });
          } else {
            return const NoItemText(
              text: "هناك خطأ في جلب بيانات الرحلة",
            );
          }
        },
      ),
    );
  }
}
