import 'package:darb_app/bloc/location_bloc/location_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Home%20Pages/student_home.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class LocationSelectPage extends StatelessWidget {
  const LocationSelectPage({super.key, this.isEdit = false});

  final bool? isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (isEdit!) ? (LocationBloc()..add(GetUserPreviousLocationEvent())) : (LocationBloc()),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is UserSelectedLocationState){
            context.showSuccessSnackBar(state.msg!);
            (isEdit!) ? context.pop() : context.push(const StudentHome(), false);
          }else if (state is StudentErrorState){
            context.showErrorSnackBar(state.msg);
          }
        },
        builder: (context, state) {
          final locationBloc = context.read<LocationBloc>();
          if(state is StudentLoadingState){
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: signatureYellowColor,),),
            );
          
          }else {
          return PlacePicker(
            apiKey: dotenv.env['googleCloudKey']!,
            onPlacePicked: (result) {
              final location = result.geometry!.location;
              locationBloc.add(SelectLocationEvent(latLng: LatLng(location.lat, location.lng), isEdit: isEdit!));
            },
            automaticallyImplyAppBarLeading: isEdit!,
            initialPosition: (state is LoadedUserPreviousLocationState) ? state.prevLocation :const LatLng(1, 1),
            useCurrentLocation: true,
            selectText: "تحديد موقع منزلك",
            hintText: "ابحث عن موقع...",
            myLocationButtonCooldown: 2,
            selectInitialPosition: (isEdit!) ? true : false,
            resizeToAvoidBottomInset:
                false,
          );
          }
        },
      ),
    );
  }
}
