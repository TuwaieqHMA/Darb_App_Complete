import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Text%20Widgets/label_of_textfield.dart';
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditTrip extends StatefulWidget {
  const EditTrip({super.key, required this.isView, required this.trip});
  final Trip trip;
  final bool isView;

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  TextEditingController busNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    busNumberController.dispose();
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
          listener: (context, state) {
            if (state is SuccessfulState) {
              context.pop();
              context.pop();
            }
            if (state is ErrorState) {
              context.showErrorSnackBar(state.msg);
              context.pop();
            }
          },
          child: Stack(
            children: [
              const WaveDecoration(
                containerColor: lightGreenColor,
              ),
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height24,
                      CircleBackButton(
                        onTap: () {
                          bloc.add(GetAllSupervisorCurrentTrip());
                          bloc.add(GetAllSupervisorFutureTrip());
                          bloc.add(RefrshDriverEvent());
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: context.getWidth() * 0.85,
                      child: Column(
                        children: [
                          height24,
                          Center(
                            child: Text(
                              widget.isView ? "بيانات الرحلة" : "تعديل الرحلة",
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: lightGreenColor),
                            ),
                          ),
                          height32,
                          const TextFieldLabel(text: "نوع الرحلة"),
                          height8,
                          BlocBuilder<SupervisorActionsBloc,
                              SupervisorActionsState>(
                            builder: (context, state) {
                              if (state is ChangeTripTypeState) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: context.getWidth() * .4,
                                      child: RadioListTile(
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          return blueColor;
                                        }),
                                        title: const Text(
                                          'ذهاب',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: blueColor),
                                        ),
                                        value: 1,
                                        groupValue:
                                            widget.trip.isToSchool == true
                                                ? bloc.seletctedType
                                                : 2,
                                        onChanged: (value) {
                                          widget.isView
                                              ? () {}
                                              : bloc.add(ChangeTripTypeEvent(
                                                  num: value!));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.getWidth() * .4,
                                      child: RadioListTile(
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          return blueColor;
                                        }),
                                        title: const Text(
                                          'عودة',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: blueColor),
                                        ),
                                        value: 2,
                                        groupValue:
                                            widget.trip.isToSchool == false
                                                ? bloc.seletctedType
                                                : 1,
                                        onChanged: (value) {
                                          widget.isView
                                              ? () {}
                                              : bloc.add(ChangeTripTypeEvent(
                                                  num: value!));
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  SizedBox(
                                    width: context.getWidth() * .4,
                                    child: RadioListTile(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return blueColor;
                                      }),
                                      title: const Text(
                                        'ذهاب',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: blueColor),
                                      ),
                                      value: 1,
                                      groupValue: bloc.seletctedType,
                                      onChanged: (value) {
                                        widget.isView
                                            ? () {}
                                            : bloc.add(ChangeTripTypeEvent(
                                                num: value!));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.getWidth() * .4,
                                    child: RadioListTile(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return blueColor;
                                      }),
                                      title: const Text(
                                        'عودة',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: blueColor),
                                      ),
                                      value: 2,
                                      groupValue: bloc.seletctedType,
                                      onChanged: (value) {
                                        widget.isView
                                            ? () {}
                                            : bloc.add(ChangeTripTypeEvent(
                                                num: value!));
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          height16,
                          height16,
                          widget.isView
                              ? BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                                  builder: (context, state) {
                                    if (state is SuccessGetDriverState) {
                                    return HeaderTextField(
                                      controller: nameController,
                                      headerText: "اسم السائق  ",
                                      hintText: locator.busDriverName?.name ?? "حدث خطأ أثناء جلب السائق",
                                      headerColor: signatureTealColor,
                                      isReadOnly: widget.isView ? false : true,
                                      isEnabled: widget.isView ? false : true,
                                    );
                                    } return nothing;
                                  },
                                )
                              : Column(
                                  children: [
                                    const TextFieldLabel(text: "اسم السائق "),
                                    height16,
                                    Container(
                                      padding: const EdgeInsets.only(right: 16),
                                      alignment: Alignment.centerRight,
                                      width: context.getWidth() * 0.9,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        border: Border.all(
                                            color: signatureTealColor,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: BlocBuilder<SupervisorActionsBloc,
                                              SupervisorActionsState>(
                                          builder: (context, state) {
                                        List<DarbUser> drivers = [];

                                        if (state is SuccessGetDriverState) {
                                          if (drivers.isEmpty) {
                                            drivers = locator.tripDrivers;
                                          }
                                          return DropdownButton(
                                            hint: Text(
                                                "${locator.busDriverName?.name}"),
                                            isExpanded: true,
                                            underline: const Text(""),
                                            menuMaxHeight: 200,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: inukFont),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            value: bloc.dropdownAddTripValue,
                                            icon: const Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 30,
                                              color: signatureBlueColor,
                                            ),
                                            items: drivers.map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(e.name, style: const TextStyle(color: blackColor),),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value is DarbUser) {
                                                bloc.add(SelectBusDriverEvent(
                                                    tripDriverId: value));
                                              }
                                            },
                                          );
                                        }
                                        return const SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              color: signatureYellowColor,
                                            ));
                                      }),
                                    ),
                                  ],
                                ),
                          height16,
                          HeaderTextField(
                            controller: locationController,
                            headerText: "الحي",
                            hintText: widget.trip.district,
                            headerColor: signatureTealColor,
                            isReadOnly: widget.isView ? false : true,
                            isEnabled: widget.isView ? false : true,
                          ),
                          height16,
                          const TextFieldLabel(text: "اليوم "),
                          height8,
                          InkWell(
                            onTap: widget.isView
                                ? () {}
                                : () {
                                    bloc.add(SelectDayEvent(context, 5));
                                  },
                            child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                width: context.getWidth() * 0.9,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: widget.isView
                                          ? fadedBlueColor
                                          : signatureTealColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: BlocBuilder<SupervisorActionsBloc,
                                        SupervisorActionsState>(
                                    builder: (context, state) {
                                  bloc.editStartTripDate ??= widget.trip.date;
                                  if (state is SelectDayState) {
                                    return Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_rounded,
                                          color: signatureBlueColor,
                                          size: 23,
                                        ),
                                        width8,
                                        Text(
                                          "${bloc.editStartTripDate?.toLocal()}"
                                              .split(' ')[0],
                                          style: const TextStyle(
                                              fontFamily: inukFont),
                                        ),
                                      ],
                                    );
                                  }
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        "${bloc.editStartTripDate?.toLocal()}"
                                            .split(' ')[0],
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                })),
                          ),
                          height16,
                          const TextFieldLabel(text: "بداية الرحلة"),
                          height8,
                          InkWell(
                            onTap: widget.isView
                                ? () {}
                                : () {
                                    bloc.add(SelectStartAndExpireTimeEvent(
                                        context, 3));
                                  },
                            child: Container(
                              padding: const EdgeInsets.only(right: 16),
                              alignment: Alignment.centerRight,
                              width: context.getWidth() * 0.9,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: widget.isView
                                          ? fadedBlueColor
                                          : signatureTealColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                                builder: (context, state) {
                                  bloc.editStartTime ??= widget.trip.timeFrom;
                                  if (state is SelectStartAndExpireTimeState) {
                                    return Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_filled,
                                          color: signatureBlueColor,
                                          size: 23,
                                        ),
                                        width8,
                                        Text(
                                          " ${bloc.editStartTime!.minute} : ${bloc.editStartTime!.hourOfPeriod} ${bloc.editStartTime!.period.name == "pm" ? "م" : "ص"} ",
                                          style: const TextStyle(
                                              fontFamily: inukFont),
                                        ),
                                      ],
                                    );
                                  }
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_filled,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        " ${bloc.editStartTime!.minute} : ${bloc.editStartTime!.hourOfPeriod} ${bloc.editStartTime!.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          height16,
                          const TextFieldLabel(text: "نهاية الرحلة"),
                          height8,
                          InkWell(
                            onTap: widget.isView
                                ? () {}
                                : () {
                                    bloc.add(SelectStartAndExpireTimeEvent(
                                        context, 4));
                                  },
                            child: Container(
                              padding: const EdgeInsets.only(right: 16),
                              alignment: Alignment.centerRight,
                              width: context.getWidth() * 0.9,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: widget.isView
                                          ? fadedBlueColor
                                          : signatureTealColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: BlocBuilder<SupervisorActionsBloc,
                                  SupervisorActionsState>(
                                builder: (context, state) {
                                  bloc.editEndTime ??= widget.trip.timeTo;
                                  if (state is SelectStartAndExpireTimeState) {
                                    return Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_filled,
                                          color: signatureBlueColor,
                                          size: 23,
                                        ),
                                        width8,
                                        Text(
                                          " ${bloc.editEndTime!.minute} : ${bloc.editEndTime!.hourOfPeriod} ${bloc.editEndTime!.period.name == "pm" ? "م" : "ص"} ",
                                          style: const TextStyle(
                                              fontFamily: inukFont),
                                        ),
                                      ],
                                    );
                                  }
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_filled,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        " ${bloc.editEndTime!.minute} : ${bloc.editEndTime!.hourOfPeriod} ${bloc.editEndTime!.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          height32,
                          widget.isView
                              ? const SizedBox.shrink()
                              : BottomButton(
                                  text: "تعديل بيانات الرحلة ",
                                  textColor: whiteColor,
                                  fontSize: 20,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                        text: "هل أنت متأكد من تعديل الرحلة ؟",
                                        onAcceptClick: () {
                                          context.pop();
                                          showDialog(barrierDismissible: false,context: context, builder: (context) {
                                            return const NoItemText(isLoading: true,);
                                          },);
                                          bloc.add(UpdateTrip(
                                            tripData: Trip(
                                              id: widget.trip.id,
                                              isToSchool: bloc.seletctedType == 1 ? true : false,
                                              district: locationController.text.isEmpty ? widget.trip.district : locationController.text,
                                              date: bloc.editStartTripDate!,
                                              driverId: bloc.dropdownAddTripValue == null ? "${locator.busDriverName!.id}" : "${bloc.dropdownAddTripValue!.id}",
                                              supervisorId: locator.currentUser.id!.toString(),
                                              timeFrom: bloc.editStartTime!,
                                              timeTo: bloc.editEndTime!,
                                            ),
                                          ));
                                        },
                                        onRefuseClick: () {
                                          context.pop();
                                        },
                                      ),
                                    );
                                  },
                                ),
                          widget.isView ? const SizedBox.shrink() : height24,
                          widget.isView
                              ? const SizedBox.shrink()
                              : BottomButton(
                                  text: "إلغاء",
                                  textColor: whiteColor,
                                  fontSize: 20,
                                  color: signatureBlueColor,
                                  onPressed: () {
                                    bloc.add(GetAllSupervisorCurrentTrip());
                                    bloc.add(GetAllSupervisorFutureTrip());
                                    context.pop();
                                  },
                                ),
                          height32,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
