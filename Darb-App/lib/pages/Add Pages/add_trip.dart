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

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  TextEditingController busNumberController = TextEditingController();

  TextEditingController tripTypeController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllTripDriver());
    super.initState();
  }

  @override
  void dispose() {
    busNumberController.dispose();
    tripTypeController.dispose();
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
              context.showSuccessSnackBar(state.msg);
              bloc.add(RefrshDriverEvent());             
            }
            if (state is ErrorState) {
              context.pop();
              context.showErrorSnackBar(state.msg);
            }
          },
          child: Stack(
            children: [
              WaveDecoration(
                containerColor: signatureBlueColor,
              ),
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height24,
                      CircleBackButton(
                        onTap: () {
                          context. pop();
                          bloc.add(RefrshDriverEvent());
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
                          const Center(
                            child: Text(
                              "إضافة رحلة",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: blueColor),
                            ),
                          ),
                          height32,
                          TextFieldLabel(text: "نوع الرحلة"),
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
                                        groupValue: bloc.seletctedType,
                                        onChanged: (value) {
                                          bloc.add(
                                              ChangeTripTypeEvent(num: value!));
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
                                          bloc.add(
                                              ChangeTripTypeEvent(num: value!));
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
                                        bloc.add(
                                            ChangeTripTypeEvent(num: value!));
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
                                        bloc.add(
                                            ChangeTripTypeEvent(num: value!));
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          height16,
                          HeaderTextField(
                            controller: busNumberController,
                            headerText: "رقم الباص",
                            hintText: "أدخل رقم الباص",
                            headerColor: signatureTealColor,
                            textDirection: TextDirection.rtl,
                          ),
                          height16,
                          TextFieldLabel(text: "اسم السائق "),
                          height16,
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            alignment: Alignment.centerRight,
                            width: context.getWidth() * 0.9,
                            height: 55,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                  color: signatureTealColor, width: 3),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child:
                             BlocBuilder<SupervisorActionsBloc,SupervisorActionsState>(
                                    builder: (context, state) {
                                    List<DarbUser> drivers = locator.tripDrivers;
                                  if (state is SuccessGetDriverState) {
                                    return DropdownButton(
                                      hint:  Text( drivers.isNotEmpty ? "اختر سائق" : "لا يوجد سائقين متاحين"),
                                      isExpanded: true,
                                      underline: const Text(""),
                                      menuMaxHeight: 200,
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: inukFont),
                                      borderRadius: BorderRadius.circular(15),
                                      value: bloc.dropdownAddTripValue,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30,
                                        color: signatureBlueColor,
                                      ),
                                      items: drivers
                                          .map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name, style: const TextStyle(color: blackColor),),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value is DarbUser) {
                                          bloc.add(SelectBusDriverEvent(tripDriverId:  value));
                                                                                  
                                        }
                                      },
                                    );
                                  }
                                  return const SizedBox(width: 10, height: 10,  child: CircularProgressIndicator(color: signatureYellowColor,));
                                }),
                             
                          
                          ),

                          height16,
                          HeaderTextField(
                            controller: locationController,
                            headerText: "الحي",
                            hintText: "أدخل اسم الحي",
                            headerColor: signatureTealColor,
                            textDirection: TextDirection.rtl,
                          ),
                          height16,
                          TextFieldLabel(text: "اليوم "),
                          height8,
                          InkWell(
                            onTap: () {
                              bloc.add(SelectDayEvent(context, 3));
                            },
                            child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                width: context.getWidth() * 0.9,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: signatureTealColor, width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: BlocBuilder<SupervisorActionsBloc,
                                        SupervisorActionsState>(
                                    builder: (context, state) {
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
                                          "${bloc.startTripDate.toLocal()}"
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
                                        bloc.startTripDate.day ==
                                                DateTime.now().day
                                            ? "أدخل يوم الرحلة "
                                            : "${bloc.startTripDate.toLocal()}"
                                                .split(' ')[0],
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                })),
                          ),
                          height16,
                          TextFieldLabel(text: "بداية الرحلة"),
                          height8,
                          InkWell(
                            onTap: () {
                              bloc.add(
                                  SelectStartAndExpireTimeEvent(context, 1));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 16),
                              alignment: Alignment.centerRight,
                              width: context.getWidth() * 0.9,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: signatureTealColor, width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: BlocBuilder<SupervisorActionsBloc,
                                  SupervisorActionsState>(
                                builder: (context, state) {
                                  if (state is LoadingState) {
                                    return SizedBox(
                                      width: context.getWidth(),
                                      height: context.getHeight(),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: signatureYellowColor,
                                        ),
                                      ),
                                    );
                                  }

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
                                          " ${bloc.startTime.minute} : ${bloc.startTime.hourOfPeriod} ${bloc.startTime.period.name == "pm" ? "م" : "ص"} ",
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
                                        bloc.startTime.hour ==
                                                TimeOfDay.now().hour
                                            ? "أدخل وقت بداية الرحلة"
                                            : " ${bloc.startTime.minute} : ${bloc.startTime.hourOfPeriod} ${bloc.startTime.period.name == "pm" ? "م" : "ص"} ",
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
                          TextFieldLabel(text: "نهاية الرحلة"),
                          height8,
                          InkWell(
                            onTap: () {
                              bloc.add(
                                  SelectStartAndExpireTimeEvent(context, 2));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 16),
                              alignment: Alignment.centerRight,
                              width: context.getWidth() * 0.9,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: signatureTealColor, width: 3),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: BlocBuilder<SupervisorActionsBloc,
                                  SupervisorActionsState>(
                                builder: (context, state) {
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
                                          " ${bloc.endTime.minute} : ${bloc.endTime.hourOfPeriod} ${bloc.endTime.period.name == "pm" ? "م" : "ص"} ",
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
                                        bloc.endTime.hour ==
                                                TimeOfDay.now().hour
                                            ? "أدخل وقت نهاية الرحلة"
                                            : " ${bloc.endTime.minute} : ${bloc.endTime.hourOfPeriod} ${bloc.endTime.period.name == "pm" ? "م" : "ص"} ",
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
                          height8,
                          BottomButton(
                            text: "إضافة",
                            textColor: whiteColor,
                            fontSize: 20,
                           onPressed: () {
                              if( bloc.dropdownAddTripValue == null ){
                                context.showErrorSnackBar("الرجاء اختبار السائق");
                              } else if (busNumberController.text.isEmpty &&
                                      locationController.text.isEmpty ) {
                                context.showErrorSnackBar("الرجاء ملئ جميع الحقول");
                                                           
                              } else if (bloc.startTripDate.day == DateTime.now().day){
                                context.showErrorSnackBar("الرجاء تغيير اليوم ، لا يسمح بإضافة رحلة في نفس اليوم ");
                              } else if (
                                !(bloc.endTime.hour > bloc.startTime.hour || (bloc.endTime.hour == bloc.startTime.hour && bloc.endTime.minute > bloc.startTime.minute )
                              )){
                                context.showErrorSnackBar("الرجاء اختار وقت النهاية بعد وقت البداية");
                              } else  {
                                
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                    text: "هل أنت متأكد من إضافة رحلة ؟",
                                    onAcceptClick: () {
                                      context.pop();
                                          showDialog(barrierDismissible: false,context: context, builder: (context) {
                                            return const NoItemText(isLoading: true,);
                                          },);
                                      bloc.add(GetAllStudent());
                                      bloc.add(AddTripEvent(
                                          trip: Trip(
                                            isToSchool: bloc.seletctedType == 1
                                                ? true
                                                : false,
                                            date: bloc.startTripDate,
                                            timeFrom: bloc.startTime,
                                            timeTo: bloc.endTime,
                                            district: locationController.text,
                                            supervisorId:
                                                locator.currentUser.id!.toString(),
                                            driverId: bloc.dropdownAddTripValue!.id!.toString() 
                                          ),
                                          ));
                                    },
                                    onRefuseClick: () {
                                      context.pop();
                                    },
                                  ),
                                );
                              }
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
