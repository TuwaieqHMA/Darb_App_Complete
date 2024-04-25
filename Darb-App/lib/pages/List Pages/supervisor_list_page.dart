import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/List%20Pages/bus_list_page.dart';
import 'package:darb_app/pages/List%20Pages/driver_list_page.dart';
import 'package:darb_app/pages/List%20Pages/student_list_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Card%20Widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SupervisorListPage extends StatelessWidget {
  const SupervisorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListCard(
            color: fadedBlueColor,
            icon: SvgPicture.asset("assets/icons/driver_bus.svg"),
            text: "قائمة السائقين",
            image: "assets/images/bg_driver.jpg",
            onTap: (){
              context.push(const DriverListPage(), true);
            },
          ),
          ListCard(
            color: signatureYellowColor,
            buttonColor: signatureBlueColor,
            icon: SvgPicture.asset("assets/icons/student_icon.svg"),
            text: "قائمة الطلاب",
            image: "assets/images/bg_st.jpg",
            onTap: (){
              context.push(const StudentListPage(), true);
            },
          ),
          ListCard(
            color: signatureBlueColor,
            icon: SvgPicture.asset("assets/icons/bus_icon.svg"),
            text: "قائمة الباصات",
            image: "assets/images/bg_buses.jpg",
            margin: 0,
            onTap: (){
              context.push(const BusListPage(), true);
            },
          ),
        ],
      ),
    );
  }
}

