import 'dart:io';

import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/pages/Home%20Pages/supervisor_home_page.dart';
import 'package:darb_app/pages/List%20Pages/supervisor_list_page.dart';
import 'package:darb_app/widgets/Card%20Widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cron/cron.dart';

class HomeData {
  final FlutterLocalization localization = FlutterLocalization.instance;
  TextDirection currentDirctionallity = TextDirection.rtl;
  int currentPageIndex = 0;
  Cron driverLocationCron = Cron();

  DateTime startDate = DateTime.now();
  DateTime? editStartDate;
  DateTime endDate = DateTime.now();
  DateTime? editEndDate;
  final List<DarbUser> drivers = [];
  late Driver driverData ;
  List<String> driverHasBus = [];
  late List<DarbUser> driverHasBusList = [];
  DarbUser? busDriverName;
  List<DarbUser> students = [];
  final List<Bus> buses = [];
  List<TripCard> supervisorCurrentTrips = [];
  List<TripCard> supervisorFutureTrips = [];
  List<DarbUser> tripDrivers = [];

  final List<Bus> seatNumber = [];

  DarbUser currentUser = DarbUser(
      name: "درب",
      email: "Darb@hotmail.com",
      phone: "0523123321",
      userType: "Supervisor");

  DarbUser currentTripDriver = DarbUser(
      name: "درب",
      email: "Darb@hotmail.com",
      phone: "0523123321",
      userType: "Driver");

  String currentUserImage =
      "https://static.vecteezy.com/system/resources/previews/008/302/458/non_2x/eps10-orange-user-solid-icon-or-logo-in-simple-flat-trendy-modern-style-isolated-on-white-background-free-vector.jpg";

  List<Widget> pageList = [
    const SupervisorHomePage(),
    const SupervisorListPage()
  ];

  Future<File?> getPickedImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  bool isGivenTimeInCurrentTime(TimeOfDay timeFrom, TimeOfDay timeTo) {
    final TimeOfDay now = TimeOfDay.now();
    int currentTimeInMinutes = now.hour * 60 + now.minute;
    int startTimeInMinutes = timeFrom.hour * 60 + timeFrom.minute;
    int endTimeInMinutes = timeTo.hour * 60 + timeTo.minute;

    return startTimeInMinutes <= currentTimeInMinutes &&
        currentTimeInMinutes <= endTimeInMinutes;
  }

  int getTimeDifference(TimeOfDay time1, TimeOfDay time2) {
    int minutes1 = time1.hour * 60 + time1.minute;
    int minutes2 = time2.hour * 60 + time2.minute;
    int differenceInMinutes = (minutes1 - minutes2).abs();

    return differenceInMinutes;
  }
}
