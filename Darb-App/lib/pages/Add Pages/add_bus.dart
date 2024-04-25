import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Button%20Widgets/bottom_button.dart';
import 'package:darb_app/widgets/Button%20Widgets/circle_back_button.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Text%20Widgets/header_text_field.dart';
import 'package:darb_app/widgets/Text%20Widgets/label_of_textfield.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AddBus extends StatefulWidget {
  const AddBus({super.key});

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  TextEditingController busNumberController = TextEditingController();
  TextEditingController seatsNumberController = TextEditingController();
  TextEditingController busPlateController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllDriverHasNotBus());
    super.initState();
  }

  @override
  void dispose() {
    busNumberController.dispose();
    seatsNumberController.dispose();
    busPlateController.dispose();
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
            if (state is SuccessAddBusState) {
              context.pop();
              context.pop();
              context.showSuccessSnackBar(state.msg);
              bloc.dropdownAddBusValue = null;
              locator.startDate = DateTime.now();
              locator.endDate = DateTime.now();
            }
            if (state is ErrorAddBusState) {
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
                        onTap: (){
                          bloc.dropdownAddBusValue = null;
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
                          const Center(
                            child: Text(
                              "إضافة باص",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: blueColor),
                            ),
                          ),
                          Column(
                            children: [
                              height32,
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
                                child: BlocBuilder<SupervisorActionsBloc,SupervisorActionsState>(
                                    builder: (context, state) {
                                    List<DarbUser> drivers = locator.driverHasBusList;
                                  if (state is SuccessGetDriverState) {
                                    return DropdownButton(
                                      hint:  Text( drivers.isNotEmpty ? "اختر سائق" : "لا يوجد سائقين متاحين"),
                                      isExpanded: true,
                                      underline: const Text(""),
                                      menuMaxHeight: 200,
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: inukFont),
                                      borderRadius: BorderRadius.circular(15),
                                      value: bloc.dropdownAddBusValue,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
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
                                          bloc.add(
                                            SelectBusDriverEvent(busDriverId:  value),
                                          );
                                        }
                                      },
                                    );
                                  }
                                  return const SizedBox(width: 10, height:  10, child: CircularProgressIndicator(color: signatureYellowColor,));
                                }),
                              ),
                              height16,
                              HeaderTextField(
                                controller: busNumberController,
                                headerText: "رقم الباص ",
                                hintText: "أدخل رقم الباص",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              HeaderTextField(
                                controller: seatsNumberController,
                                headerText: "عدد المقاعد",
                                hintText: "أدخل عدد مقاعد الباص",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              HeaderTextField(
                                controller: busPlateController,
                                headerText: "لوحة الباص",
                                hintText:
                                    "أدخل لوحة الباص مثل ( هـ م هـ - 2024 ) ",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              TextFieldLabel(text: " تاريخ اصدار الرخصة "),
                              height8,
                              InkWell(
                                onTap: () {
                                  bloc.add(SelectDayEvent(context, 1));
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
                                              "${locator.startDate.toLocal()}"
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
                                          Text( locator.startDate.day == DateTime.now().day
                                                ? "أدخل تاريخ اصدار الرخصة"
                                                : "${locator.startDate.toLocal()}"
                                                    .split(' ')[0],
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
                              TextFieldLabel(text: " تاريخ انتهاء الرخصة "),
                              height8,
                              InkWell(
                                onTap: () {
                                  bloc.add(SelectDayEvent(context, 2));
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
                                              "${locator.endDate.toLocal()}"
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
                                            locator.startDate.day ==
                                                    DateTime.now().day
                                                ? "أدخل تاريخ انتهاء الرخصة"
                                                : "${locator.endDate.toLocal()}"
                                                    .split(' ')[0],
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
                                  if(
                                    bloc.dropdownAddBusValue == null
                                  ){
                                    context.showErrorSnackBar("الرجاء اختيار السائق");
                                  }  else if (
                                    busNumberController.text.isEmpty &&
                                    seatsNumberController
                                          .text.isEmpty &&
                                      busPlateController.text.isEmpty 
                                     ){ context.showErrorSnackBar(
                                        "الرجاء ملئ جميع الحقول");
                                        
                                      }else if (locator.startDate.month >
                                      locator.endDate.month) {
                                    context.showErrorSnackBar("تاريخ انتهاء الرخصة يجب أن يكون بعد تاريخ الإصدار");
                                  } else if (locator.startDate.day >=
                                      locator.endDate.day) {
                                    context.showErrorSnackBar("تاريخ انتهاء الرخصة يجب أن يكون بعد تاريخ الإصدار");
                                  }else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                        text: "هل أنت متأكد من إضافة باص ؟",
                                        onAcceptClick: () {
                                          bloc.add(AddBusEvent(
                                            bus: Bus(
                                              supervisorId:
                                                  locator.currentUser.id!,
                                              seatsNumber: int.parse(
                                                  seatsNumberController.text),
                                              busPlate: busPlateController.text,
                                              dateIssue: locator.startDate,
                                              dateExpire: locator.endDate,
                                              driverId: bloc.dropdownAddBusValue!.id.toString(),
                                            ),
                                            id: bloc.dropdownAddBusValue!.id.toString(),
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
                            ],
                          ),
                          Image.asset("assets/images/add_bus_img.png",
                            width: context.getWidth(),
                            height: context.getHeight() * .35,
                          ),
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
