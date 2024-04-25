import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Edit%20Pages/edit_driver.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Text%20Widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/Screen%20Widgets/dialog_box.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:darb_app/widgets/Card%20Widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DriverListPage extends StatefulWidget {
  const DriverListPage({super.key});

  @override
  State<DriverListPage> createState() => _DriverListPageState();
}

class _DriverListPageState extends State<DriverListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllDriver());
    bloc.add(GetAllTripDriver());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .21),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة السائقين",
          bottom: PreferredSize(
            preferredSize: Size(context.getWidth(), 72),
            child: Container(
              width: context.getWidth(),
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                  color: offWhiteColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 4))
                  ]),
              child: CustomSearchBar(
                controller: searchController,
                hintText: "ابحث عن سائق...",
                onChanged: (value) {
                  if (value.isEmpty) {
                    bloc.add(GetAllDriver());
                    bloc.add(GetAllTripDriver());
                  }
                },
                onEditingComplete: () {
                  bloc.add(
                      SearchForDriverEvent(driverName: searchController.text));
                },
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
        listener: (context, state) {
          if (state is SuccessfulState) {
            context.showSuccessSnackBar(state.msg);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          children: [
            BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
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
              } else if (state is SearchForDriverState) {
                if(state.drivers.isNotEmpty){
                return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.drivers.length,
                    itemBuilder: (context, index) {
                      return PersonCard(
                        user: state.drivers[index],
                        name: state.drivers[index].name,
                        isSigned: (locator.driverHasBus.contains(state.drivers[index].id))
                            ? false
                            : true,
                        onView: () {
                          context.push(
                              EditDriver(
                                driver: state.drivers[index],
                                isView: true,
                              ),
                              true);
                        },
                        onEdit: () {
                          context.push(
                              EditDriver(
                                driver: state.drivers[index],
                                isView: false,
                              ),
                              true);
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) => DialogBox(
                              text: "هل أنت متأكد من حذف السائق ؟",
                              onAcceptClick: () {
                                bloc.add(DeleteDriver(
                                    driverId:
                                        state.drivers[index].id.toString()));
                                context.pop();
                              },
                              onRefuseClick: () {
                                context.pop();
                              },
                            ),
                          );
                        },
                      );
                    });
                } return const Center(child: Text("لا توجد نتائج .."));
              } else {
                if (locator.drivers.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: locator.drivers.length,
                      itemBuilder: (context, index) {
                        return PersonCard(
                          user: locator.drivers[index],
                          name: locator.drivers[index].name,
                          isSigned: (locator.driverHasBus
                                  .contains(locator.drivers[index].id))
                              ? false
                              : true,
                          onView: () {
                            context.push(
                                EditDriver(
                                  driver: locator.drivers[index],
                                  isView: true,
                                ),
                                true);
                          },
                          onEdit: () {
                            context.push(
                                EditDriver(
                                  driver: locator.drivers[index],
                                  isView: false,
                                ),
                                true);
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                text: "هل أنت متأكد من حذف السائق ؟",
                                onAcceptClick: () {
                                  bloc.add(DeleteDriver(
                                      driverId: locator.drivers[index].id.toString()));
                                  context.pop();
                                },
                                onRefuseClick: () {
                                  context.pop();
                                },
                              ),
                            );
                          },
                        );
                      });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    height32,
                    Image.asset("assets/images/empty_driver.png"),
                    const Text(
                      "لا يوجد سائقين مضافين حالياً",
                      style: TextStyle(fontSize: 16, color: signatureBlueColor),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
