import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/Card%20Widgets/bus_card.dart';
import 'package:darb_app/widgets/Text%20Widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BusListPage extends StatefulWidget {
  const BusListPage({super.key});

  @override
  State<BusListPage> createState() => _BusListPageState();
}

class _BusListPageState extends State<BusListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllBus());

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .21),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة الباصات",
          bottom: PreferredSize(
            preferredSize: Size(context.getWidth(), 72),
            child: Container(
              width: context.getWidth(),
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: offWhiteColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 4, offset: const Offset(0, 4))
                ]
              ),
              child: CustomSearchBar(controller: searchController, hintText: "ابحث عن رقم باص...", 
              inputFormatters: [FilteringTextInputFormatter.digitsOnly ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                  if(value.isEmpty){
                    bloc.add(GetAllBus());
                  }else{
                  bloc.add(SearchForBusEvent(busNumber: int.tryParse(searchController.text)!));
                  }
                },),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,),
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
            }
            if (state is SearchForBusState) {
              if(state.bus.isNotEmpty){
               return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.bus.length, 
                    itemBuilder: (context, index) {
                      return           
                      BusCard(
                        bus: state.bus[index],
                        busId: state.bus[index].id! , 
                        busPlate: state.bus[index].busPlate, 
                        startDate: state.bus[index].dateIssue, 
                        endDate: state.bus[index].dateExpire,);
                    });
              } return const Center(child: Text("لا توجد نتائج .."));
             
            }
            if (state is GetAllBusState) {
              if (locator.buses.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: locator.buses.length,
                    itemBuilder: (context, index) {
                      return           
                      BusCard(
                        bus: locator.buses[index],
                        busId: locator.buses[index].id! , 
                        busPlate: locator.buses[index].busPlate, 
                        startDate: locator.buses[index].dateIssue, 
                        endDate: locator.buses[index].dateExpire,);
                    });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  height32,
                  Image.asset("assets/images/bus_vector.png"),
                  height24,
                  const Text(
                    "لا توجد باصات مضافة حالياً",
                    style: TextStyle(fontSize: 16, color: signatureBlueColor),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
         ],
      ),
    );
  }
}

