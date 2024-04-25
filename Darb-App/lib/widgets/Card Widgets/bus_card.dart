import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/pages/Edit%20Pages/edit_bus.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/Text%20Widgets/icon_text_bar.dart';
import 'package:darb_app/widgets/Button%20Widgets/more_button.dart';
import 'package:darb_app/widgets/Text%20Widgets/svg_text_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusCard extends StatelessWidget {
  const BusCard({
    super.key,
    required this.bus,
    required this.busId,
    required this.busPlate,
    required this.startDate,
    required this.endDate,
  });
  final Bus bus;

  final int busId;
  final String busPlate;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

    return BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
      listener: (context, state) {
        if(state is SuccessfulState){
           context.showSuccessSnackBar(state.msg);
        }
      },
      child: Container(
        width: context.getWidth(),
        height: 145,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgTextBar(text: "$busId", svgUrl: "assets/icons/circle_bus_icon.svg",),
                IconTextBar(text: busPlate, icon: Icons.call_to_action_rounded),
                IconTextBar(
                    text: formatDate(startDate),
                    icon: Icons.calendar_today_rounded),
                IconTextBar(
                    text: formatDate(endDate),
                    icon: Icons.calendar_today_outlined)
              ],
            ),
            MoreButton(
              onViewClick: () {
                bloc.add(GetDriverBusNameEvent(busData:  bus));
                context.push(
                    EditBus(
                      bus: bus ,
                      isView: true,
                      isEdit: false,
                    ),
                    true);
              },
              onEditClick: () {
                bloc.add(GetDriverBusNameEvent(busData:  bus));
                context.push(
                    EditBus(
                      bus: bus,
                      isView: false,
                      isEdit: true,
                    ),
                    true);
              },
              onDeleteClick: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogBox(
                    text: "هل أنت متأكد من حذف الباص ؟",
                    onAcceptClick: () {
                      bloc.add(DeleteBus(
                          busId: busId.toString(), driverId: bus.driverId));
                      context.pop();
                    },
                    onRefuseClick: () {
                      context.pop();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


