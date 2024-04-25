import 'package:darb_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Add%20Pages/supervisor_add_type_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class SupervisorNavigationPage extends StatelessWidget {
  const SupervisorNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final navBloc = context.read<NavigationBloc>();
          return Scaffold(
            appBar: PreferredSize(preferredSize: Size(context.getWidth(), context.getHeight() * .10), child: const HomeAppBar()),
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: locator.currentPageIndex,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: whiteColor,
                  selectedItemColor: whiteColor,
                  backgroundColor: lightGreenColor,
                  selectedLabelStyle: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(color: whiteColor, fontFamily: inukFont, fontSize: 16, ),
                  items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 32,), label: "الرئيسية", activeIcon: Icon(Icons.home_filled, size: 34, color: signatureYellowColor,)),
                  BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.rectangleList, size: 31,), label: "البيانات", activeIcon: FaIcon(FontAwesomeIcons.solidRectangleList, size: 33, color: signatureYellowColor,)),
                ],
                onTap: (index) {
                  navBloc.add(ChangePageEvent(index: index));
                },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    context.push(const SupervisorAddTypePage(), true);
                  }, shape: const CircleBorder(
                    side: BorderSide(
                      color: whiteColor,
                      width: 6,
                      strokeAlign: BorderSide.strokeAlignOutside
                    )
                  ), backgroundColor: signatureYellowColor, child: const Icon(Icons.add, color: whiteColor, size: 38,),),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                body: locator.pageList[locator.currentPageIndex],
              );
        },
      ),
    );
  }
}
