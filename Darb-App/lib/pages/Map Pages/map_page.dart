import 'package:darb_app/bloc/driver_map_bloc/driver_map_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.trip,
  });
  final Trip trip;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;

  @override
  void initState() {
    final driverMapBloc = context.read<DriverMapBloc>();
    driverMapBloc.add(GetDriverMapLocationEvent(tripid: widget.trip.id!));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.10,
        ),
        child: const PageAppBar(
          title: "الخريطة",
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
        ),
      ),
      body: BlocBuilder<DriverMapBloc, DriverMapState>(
        builder: (context, state) {
          if(state is DriverMapLoadingState){
            return NoItemText(height: context.getHeight(), isLoading: true,);
          }
          if (state is DriverMapStudentListState) {
          return GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: state.driverLocation,
              zoom: 16.0, 
            ),
            markers: state.markers,
            polylines: state.polylines,
            mapType: MapType.normal,
            myLocationEnabled: true, 
            onMapCreated: (controller) {
              mapController = controller;
              setState(() {
              });
            },
          );
          } else if (state is DriverMapErrorState) {
      return NoItemText(height: context.getHeight(),text: state.msg,);
    } else {
      return NoItemText(height: context.getHeight(),text: 'لا يوجد بيانات لعرضها',);
    }
        },
      ),
    );
  }
}
