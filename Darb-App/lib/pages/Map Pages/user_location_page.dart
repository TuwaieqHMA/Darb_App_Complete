import 'package:darb_app/bloc/permission_bloc/permission_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Home%20Pages/driver_home.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Redirection%20Widgets/redirect_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationPage extends StatelessWidget {
  const UserLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return BlocProvider(
      create: (context) =>
          PermissionBloc()..add(CheckLocationPermissionEvent()),
      child: Scaffold(
        backgroundColor: offWhiteColor,
        body: BlocConsumer<PermissionBloc, PermissionState>(
          listener: (context, state) {
            if (state is LocationPermissionDeniedState) {
              context.showErrorSnackBar(state.msg);
            } else if (state is LocationPermissionPreviouslyGrantedState) {
              context.push(locator.currentUser.userType == "Student" ? const RedirectLocationWidget() : const DriverHome(), false);
            } else if (state is LocationPermissionGrantedState) {
              context.showSuccessSnackBar(state.msg);
              context.push(locator.currentUser.userType == "Student" ? const RedirectLocationWidget() : const DriverHome(), false);
            } else if (state is RequestAppSettingsState) {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                    text: "هل تريد الذهاب إلى الإعدادات لتفعيل الموقع؟",
                    onAcceptClick: () {
                      openAppSettings();
                    },
                    onRefuseClick: () {
                      context.pop();
                    },
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if(state is PermissionLoadingState){
              return const Center(child: CircularProgressIndicator(color: signatureYellowColor,),);
            }else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(locator.currentUser.userType == "Student" ? 'assets/images/s-l-p.png' : 'assets/images/bus_location.png'),
                height32,
                Text(
                  locator.currentUser.userType == "Student" ? " لكي تتمكن من استخدام التطبيق يجب \n عليك السماح باستخدام موقعك , وتحديد \n موقع منزلك" : "لكي تتمكن من إستخدام التطبيق عليك السماح بإستخدام موقعك",
                  style: TextStyle(
                    color: signatureTealColor,
                    fontFamily: inukFont,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 8.0,
                        color: shadowblackColor,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
            }
          },
        ),
        bottomSheet: BlocBuilder<PermissionBloc, PermissionState>(
          builder: (context, state) {
            final permissionBloc = context.read<PermissionBloc>();
            if(state is PermissionLoadingState){
              return nothing;
            }else {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              child: BottomButton(
                text: locator.currentUser.userType == "Student" ? " حدد موقعي " : "السماح بالوصول للموقع",
                onPressed: () {
                  permissionBloc.add(RequestNormalOrSettingsEvent());
                },
                textColor: whiteColor,
                fontSize: 24,
              ),
            );
            }
          },
        ),
      ),
    );
  }
}
