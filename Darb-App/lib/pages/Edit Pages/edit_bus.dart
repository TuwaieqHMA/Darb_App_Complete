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
import 'package:darb_app/widgets/Text%20Widgets/no_item_text.dart';
import 'package:darb_app/widgets/Art%20and%20Container%20Widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditBus extends StatefulWidget {
  const EditBus({
    super.key,
    required this.isView,
    required this.isEdit,
    required this.bus,
  });
  final bool isView;
  final bool isEdit;
  final Bus bus;

  @override
  State<EditBus> createState() => _EditBusState();
}

class _EditBusState extends State<EditBus> {
  TextEditingController nameController = TextEditingController();
  TextEditingController busNumberController = TextEditingController();
  TextEditingController seatsNumberController = TextEditingController();
  TextEditingController busPlateController = TextEditingController();

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    nameController.dispose();
    busNumberController.dispose();
    seatsNumberController.dispose();
    busPlateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllDriverHasNotBus());
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
            }
            if (state is ErrorState) {
              context.pop();
              context.showErrorSnackBar(state.msg);
            }
          },
          child: Stack(
            children: [
              WaveDecoration(
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
                          bloc.add(GetAllBus());
                          bloc.dropdownAddBusValue = null;
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  height16,
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: context.getWidth() * 0.85,
                      child: Column(
                        children: [
                          height16,
                          Center(
                            child: Text(
                              widget.isView ? "بيانات الباص" : "تعديل الباص",
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: lightGreenColor),
                            ),
                          ),
                          Column(
                            children: [
                              height32,
                              widget.isView
                                  ? BlocBuilder<SupervisorActionsBloc,
                                      SupervisorActionsState>(
                                      builder: (context, state) {
                                        if (state is SuccessGetDriverState) {
                                          return HeaderTextField(
                                            controller: nameController,
                                            hintText:
                                                locator.busDriverName?.name ??
                                                    "حدث خطأ أثناء جلب السائق",
                                            headerText: "اسم السائق",
                                            isEnabled:
                                                widget.isView ? false : true,
                                            headerColor: signatureTealColor,
                                            textDirection: TextDirection.rtl,
                                            isReadOnly:
                                                widget.isView ? true : false,
                                          );
                                        }
                                        return nothing;
                                      },
                                    )
                                  : Column(
                                      children: [
                                        TextFieldLabel(text: "اسم السائق "),
                                        height16,
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 16),
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
                                          child: BlocBuilder<
                                                  SupervisorActionsBloc,
                                                  SupervisorActionsState>(
                                              builder: (context, state) {
                                            List<DarbUser> drivers = [];

                                            if (state
                                                is SuccessGetDriverState) {
                                              if (drivers.isEmpty) {
                                                drivers =
                                                    locator.driverHasBusList;
                                              }
                                              return DropdownButton(
                                                hint: Text(
                                                  "${locator.busDriverName?.name}",
                                                ),
                                                isExpanded: true,
                                                underline: const Text(""),
                                                menuMaxHeight: 200,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: inukFont),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                value: bloc.dropdownAddBusValue,
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  size: 30,
                                                  color: signatureBlueColor,
                                                ),
                                                items: drivers.map((e) {
                                                  return DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.name,
                                                      style: const TextStyle(
                                                          color: blackColor),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (value is DarbUser) {
                                                    bloc.add(
                                                      SelectBusDriverEvent(
                                                          busDriverId: value),
                                                    );
                                                  }
                                                },
                                              );
                                            }
                                            return const SizedBox(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: signatureYellowColor,
                                                ));
                                          }),
                                        ),
                                      ],
                                    ),
                              height16,
                              HeaderTextField(
                                controller: busNumberController,
                                headerText: "رقم الباص ",
                                hintText: widget.bus.id.toString(),
                                isEnabled: widget.isView ? false : false,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : true,
                              ),
                              height16,
                              HeaderTextField(
                                controller: seatsNumberController,
                                headerText: "عدد المقاعد",
                                hintText: widget.bus.seatsNumber.toString(),
                                isEnabled: widget.isView ? false : true,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: busPlateController,
                                headerText: "لوحة الباص",
                                hintText: widget.bus.busPlate,
                                isEnabled: widget.isView ? false : true,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              ),
                              height16,
                              TextFieldLabel(text: " تاريخ اصدار الرخصة "),
                              height8,
                              InkWell(
                                onTap: widget.isView
                                    ? () {}
                                    : () {
                                        bloc.add(SelectDayEvent(context, 4));
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
                                      locator.editStartDate ??=
                                          locator.buses[0].dateExpire;

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
                                              "${locator.editStartDate?.toLocal()}"
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
                                            "${locator.editStartDate!.toLocal()}"
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
                                      )),
                                  child: BlocBuilder<SupervisorActionsBloc,SupervisorActionsState>(
                                    builder: (context, state) {
                                      locator.editEndDate ??=
                                          locator.buses[0].dateExpire;

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
                                              "${locator.editEndDate!.toLocal()}"
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
                                            "${locator.editEndDate!.toLocal()}"
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
                              widget.isView
                                  ? const SizedBox.shrink()
                                  : BottomButton(
                                      text: "تعديل بيانات الباص",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogBox(
                                            text:
                                                "هل أنت متأكد من تعديل الباص ؟",
                                            onAcceptClick: () {
                                              context.pop();
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return const NoItemText(
                                                    isLoading: true,
                                                  );
                                                },
                                              );
                                              bloc.add(UpdateBus(
                                                busData: Bus(
                                                  id: widget.bus.id,
                                                  supervisorId:
                                                      locator.currentUser.id!,
                                                  seatsNumber:
                                                      seatsNumberController
                                                              .text.isEmpty
                                                          ? widget
                                                              .bus.seatsNumber
                                                          : int.parse(
                                                              seatsNumberController
                                                                  .text),
                                                  busPlate: busPlateController
                                                          .text.isEmpty
                                                      ? widget.bus.busPlate
                                                      : busPlateController.text,
                                                  dateIssue:
                                                      locator.editStartDate!,
                                                  dateExpire:
                                                      locator.editEndDate!,
                                                  driverId: bloc
                                                              .dropdownAddBusValue ==
                                                          null
                                                      ? "${locator.busDriverName!.id}"
                                                      : "${bloc.dropdownAddBusValue!.id}",
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
                              widget.isView
                                  ? const SizedBox.shrink()
                                  : height24,
                              widget.isView
                                  ? const SizedBox.shrink()
                                  : BottomButton(
                                      text: "إلغاء",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      color: signatureBlueColor,
                                      onPressed: () {
                                        bloc.add(GetAllBus());
                                        context.pop();
                                      },
                                    ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/add_bus_img.png",
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
