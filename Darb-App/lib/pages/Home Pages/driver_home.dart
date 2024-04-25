import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/home_appbar.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    final driverBloc = context.read<DriverBloc>();
    driverBloc.add(GetAllDriverTripsEvent());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .10),
          child: const HomeAppBar(
            backgroundColor: signatureBlueColor,
            textColor: whiteColor,
          )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "الرحلة الحالية",
            style: TextStyle(
              color: blackColor,
              fontFamily: inukFont,
              fontSize: 30,
            ),
          ),
          height24,
          BlocConsumer<DriverBloc, DriverState>(
            listener: (context, state) {
              if (state is DriverErrorState){
                context.showErrorSnackBar(state.msg);
              }
            },
            builder: (context, state) {
              if (state is DriverLoadingState) {
                return const NoItemText(
                  isLoading: true,
                );
              } else if (state is DriverLoadedTripsState) {
                return Column(
                  children: [
                    (state.currentTrip != null)
                        ? state.currentTrip!
                        : const NoItemText(text: "لا يوجد رحلة حالياً")
                  ],
                );
              } else {
                return const NoItemText(
                  textColor: redColor,
                  text: "هناك خطأ في تحميل الرحلة الحالية",
                );
              }
            },
          ),
          height24,
          const Text(
            "الرحلات القادمة",
            style: TextStyle(
              color: blackColor,
              fontFamily: inukFont,
              fontSize: 30,
            ),
          ),
          height24,
          BlocBuilder<DriverBloc, DriverState>(
            builder: (context, state) {
              if (state is DriverLoadingState) {
                return const NoItemText(
                  isLoading: true,
                );
              } else if (state is DriverLoadedTripsState) {
                return Column(
                  children: (state.tripCardList.isNotEmpty)
                      ? state.tripCardList
                      : [
                          const NoItemText(
                            text: "لا يوجد رحلات قادمة",
                          ),
                        ],
                );
              } else {
                return const NoItemText(
                  textColor: redColor,
                  text: "هناك خطأ في تحميل الرحلات القادمة",
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<DriverBloc, DriverState>(
        builder: (context, state) {
          final driverBloc = context.read<DriverBloc>();
          if (state is DriverLoadingState) {
            return nothing;
          } else {
            return FloatingActionButton(
              onPressed: () {
                driverBloc.add(GetAllDriverTripsEvent());
              },
              shape: const CircleBorder(),
              backgroundColor: signatureYellowColor,
              child: const Icon(
                Icons.refresh_rounded,
                color: whiteColor,
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
