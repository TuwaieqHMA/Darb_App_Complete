import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/Card%20Widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllSupervisorCurrentTrip());
    bloc.add(GetAllSupervisorFutureTrip());

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      body: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
        listener: (context, state) {
          if (state is SuccessfulState) {
            context.showSuccessSnackBar(state.msg);
          }
          if (state is ErrorState) {
            context.showErrorSnackBar(state.msg);
          }
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            const Text(
              "الرحلات الحالية",
              style: TextStyle(
                color: blackColor,
                fontFamily: inukFont,
                fontSize: 30,
              ),
            ),
            height24,
            BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                builder: (context, state) {
              if (state is LoadingSupervisorTripState) {
                return const NoItemText(isLoading: true, height: 100,);
              } else if (state is GetAllSupervisorTripsState) {
                if (locator.supervisorCurrentTrips.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: locator.supervisorCurrentTrips.length,
                      primary: false,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TripCard(
                              userType: UserType.supervisor,
                              trip: locator.supervisorCurrentTrips[index].trip,
                              driverName: locator
                                  .supervisorCurrentTrips[index].driverName,
                              noOfPassengers: locator
                                  .supervisorCurrentTrips[index].noOfPassengers,
                              driver:
                                  locator.supervisorCurrentTrips[index].driver,
                              isCurrent: true,
                            ),
                            height16,
                          ],
                        );
                      });
                }
                return const NoItemText(text: "لا توجد رحلات حالياً");
              }
              return const NoItemText(
                isLoading: true,
              );
            }),
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
            BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                builder: (context, state) {
              if (state is LoadingSupervisorTripState) {
                return const NoItemText(isLoading: true, height: 100,);
              }
              if (state is GetAllSupervisorTripsState) {
                if (locator.supervisorFutureTrips.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locator.supervisorFutureTrips.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TripCard(
                              userType: UserType.supervisor,
                              trip: locator.supervisorFutureTrips[index].trip,
                              driverName: locator
                                  .supervisorFutureTrips[index].driverName,
                              noOfPassengers: locator
                                  .supervisorFutureTrips[index].noOfPassengers,
                              driver:
                                  locator.supervisorFutureTrips[index].driver,
                            ),
                            height16,
                          ],
                        );
                      });
                }
                return const NoItemText(text: "لا توجد رحلات حالياً");
              }
              return const NoItemText(
                isLoading: true,
              );
            }),
          ],
        ),
      ),
      floatingActionButton:
          BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
        builder: (context, state) {
          if ((state is LoadingSupervisorTripState)) {
            return nothing;
          } else {
            return FloatingActionButton(
              onPressed: () {
                bloc.add(GetAllSupervisorCurrentTrip());
                bloc.add(GetAllSupervisorFutureTrip());
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
