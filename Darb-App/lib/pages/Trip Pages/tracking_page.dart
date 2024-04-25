import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/bloc/trip_details_bloc/trip_details_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/Map%20Pages/map_student.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/container_tracking.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Card%20Widgets/driver_info_card.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({
    super.key,
    required this.trip,
    this.isCurrent = false,
  });

  final Trip trip;
  final bool? isCurrent;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return BlocProvider(
      create: (context) =>
          TripDetailsBloc()..add(GetDriverInfoEvent(driverId: trip.driverId)),
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          if (didPop && locator.currentUser.userType == "Student") {
            final studentBloc = context.read<StudentBloc>();
            studentBloc.add(GetAllStudentTripsEvent());
          } else if (didPop && locator.currentUser.userType == "Driver") {
            final driverBloc = context.read<DriverBloc>();
            driverBloc.add(GetAllDriverTripsEvent());
          }
        },
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: PreferredSize(
              preferredSize:
                  Size(context.getWidth(), context.getHeight() * .10),
              child: const PageAppBar(
                title: "تفاصيل الرحلة",
                backgroundColor: signatureBlueColor,
                textColor: whiteColor,
              )),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                (TimeOfDay.now().hour < 12) ? "صباح الخير" : "مساء الخير",
                style: const TextStyle(
                  color: signatureBlueColor,
                  fontFamily: inukFont,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height16,
              BlocConsumer<TripDetailsBloc, TripDetailsState>(
                listener: (context, state) {
                  if (state is ChangedAttendanceStatusState){
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text(state.msg),
                      );
                    },);
                  }
                },
                builder: (context, state) {
                  if (state is TripDetailsErrorState) {
                    return NoItemText(
                      text: "هناك خطأ في تحميل بيانات السائق",
                      height: context.getWidth() * 0.360,
                    );
                  } else if (state is DriverInfoLoadingState) {
                    return NoItemText(
                      isLoading: true,
                      height: context.getWidth() * 0.360,
                    );
                  } else {
                    return DriverInfoCard(
                        driver: locator.currentTripDriver,
                        isCurrent: isCurrent!);
                  }
                },
              ),
              height32,
              SizedBox(
                width: context.getWidth(),
                height: context.getHeight() * .39,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Image.asset(
                      "assets/images/line.png",
                      width: 10,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContainerTracking(
                        text: trip.timeFrom.format(context),
                        color: signatureYellowColor,
                        height: 40,
                        img: 'assets/images/1BUS.png',
                      ),
                      ContainerTracking(
                        text:
                            "${locator.getTimeDifference(trip.timeFrom, trip.timeTo)} دقيقة",
                        color: signatureTealColor,
                        height: 40,
                        img: 'assets/images/2BUS.png',
                      ),
                      ContainerTracking(
                        text: trip.timeTo.format(context),
                        color: signatureYellowColor,
                        height: 40,
                        img: 'assets/images/3BUS.png',
                      ),
                    ],
                  ),
                ]),
              ),
              height32,
              (isCurrent!)
                  ? BottomButton(
                      text: "تتبع الباص",
                      onPressed: () {
                        context.push(MapStudent(driverId: trip.driverId,), true);
                      },
                      textColor: whiteColor,
                      fontSize: 24,
                    )
                  : BlocConsumer<TripDetailsBloc, TripDetailsState>(
                      listener: (context, state) {
                        if (state is RecievedAttendanceStatusState) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final tripDetailsBloc =
                                  context.read<TripDetailsBloc>();
                              return DialogBox(
                                text:
                                    "حالة حضورك الان هي:\n ${state.status == AttendanceStatus.assueredPrecense ? "حضور مؤكد" : "غائب"}",
                                acceptText: (state.status ==
                                        AttendanceStatus.assueredPrecense)
                                    ? "تغيير لغائب"
                                    : "تغيير لحاضر",
                                onAcceptClick: () {
                                  context.pop();
                                  tripDetailsBloc.add(
                                      ChangeAttendanceStatusEvent(
                                          currentStatus: state.status,
                                          tripId: trip.id));
                                },
                                onRefuseClick: () {
                                  context.pop();
                                  tripDetailsBloc.add(GetDriverInfoEvent(
                                      driverId: trip.driverId));
                                },
                              );
                            },
                          );
                        } else if (state is TripDetailsErrorState) {
                          context.showErrorSnackBar(state.msg);
                        }
                      },
                      builder: (context, state) {
                        if (state is AttendanceStatusLoadingState) {
                          return const NoItemText(
                            isLoading: true,
                            height: 50,
                          );
                        } else {
                          return BottomButton(
                            text: "تحديث حالة الحضور",
                            color: signatureTealColor,
                            onPressed: () {
                              final tripDetailsBloc =
                                  context.read<TripDetailsBloc>();
                              tripDetailsBloc.add(
                                  GetCurrentAttendanceStatusEvent(
                                      tripId: trip.id!));
                            },
                            textColor: whiteColor,
                            fontSize: 24,
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
