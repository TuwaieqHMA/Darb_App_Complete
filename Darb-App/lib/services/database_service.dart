import 'dart:async';
import 'dart:io';
import 'package:cron/cron.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/widgets/Card%20Widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DBService {
  final supabase = Supabase.instance.client; 
  final List<Driver> driverData = [];

  final locator = GetIt.I.get<HomeData>();

//---------------Supervisor Actions---------------

  // Get All basic user information
  Future getAllDriver() async {
    final driver =
        await supabase.rpc('get_all_driver_with_supervisor', params: {'supervisorid': locator.currentUser.id});
    locator.drivers.clear();
    for (var element in driver) {
      locator.drivers.add(DarbUser.fromJson(element));
    }
    await getDriverState();
  }

  // Get All basic user information
  Future getAllUser() async {
    List<DarbUser> studentList = [];
    final std = await supabase.rpc('get_student_with_supervisor', params: {'supervisorid': locator.currentUser.id});

    for (var element in std) {
      studentList.add(DarbUser.fromJson(element));
    }
    locator.students = studentList;
  }

  // Get driver state
  Future getDriverState() async {
    List<String> driver = [];
    final stateDrive = await supabase.from("Driver").select('id').eq('has_bus', false);
    for (var element in stateDrive) {
      driver.add(element['id']);      
    }
    locator.driverHasBus = driver;
    
  }

  // Get Driver information
  Future<Driver> getDriverData(String driverId) async {
    final data = await supabase.rpc('get_diver_info' , params: {'driverid': driverId}).single();
    Driver driverInfo = Driver.fromJson(data);
    locator.driverData = driverInfo;
    return driverInfo;
  }

  // Get driver does not has bus
  Future<List<DarbUser>> getDriversWithoutBus() async {
    List<DarbUser> busDriver = [];
    final driver = await supabase.rpc('fetch_driver_without_bus', params: {'supervisorid' : locator.currentUser.id});
    for (var element in driver) {
      busDriver.add(DarbUser.fromJson(element));      
    }
    locator.driverHasBusList = busDriver;
    return busDriver;
  }
  
 
  Future getDriverBusName(String driverId) async {
    final data = await supabase.from("User").select().eq('id', driverId).single();

    locator.busDriverName = DarbUser.fromJson(data);
  }
  
   
  // Get driver has max trip
  Future getDriversWithoutTrip() async {
    List<DarbUser> tripDriver = [];
    final data = await supabase.rpc('fetch_available_driver_for_trip', params: {'supervisorid' : locator.currentUser.id});
    for (var e in data) {
      tripDriver.add(DarbUser.fromJson(e));
    }
    locator.tripDrivers = tripDriver;
  }

  // Search for driver
  Future<List<DarbUser>> searchForDriver(String driverName) async {
    List<DarbUser> searchDriver = [];
    final data = await supabase.rpc('search_for_driver', params: {'driver_name': driverName, 'supervisorid': locator.currentUser.id});
      for (var user in data) {
        searchDriver.add(DarbUser.fromJson(user));
      }
    return searchDriver;
  }

  // Search for student
  Future<List<DarbUser>> searchForStudent(String studentName) async {
    List<DarbUser> searchStudent = [];
    final data = await supabase.rpc('search_for_student', params: {'student_name': studentName, 'supervisorid': locator.currentUser.id});
      for (var user in data) {
        searchStudent.add(DarbUser.fromJson(user));
      }
    return searchStudent;
  }

  // Search for bus
  Future<List<Bus>> searchForBus(int busNumber) async {
    List<Bus> searchBus = [];
    final data = await supabase.from("Bus").select().match({'id' : busNumber, 'supervisor_id' : locator.currentUser.id});
      for (var user in data) {
        searchBus.add(Bus.fromJson(user));
      }
    return searchBus;
  }

  // Get Bus information
  Future getAllBuses() async {
    final bus = await supabase.from('Bus').select('*').eq('supervisor_id', locator.currentUser.id!);
    locator.buses.clear();
    for (var element in bus) {
      locator.buses.add(Bus.fromJson(element));
    }
  }

  // Delete bus function
  Future deleteBus(String busId, String driverId) async {
    await supabase.from("Bus").delete().eq('id', busId);
    await supabase
        .from('Driver')
        .update({'has_bus': false}).eq('id', driverId);
    await getAllBuses();
  }

  // Delete student function
  Future deleteStudent(String studentIdd) async {
    await supabase.from("Student").update({'supervisor_id': null}).eq('id', studentIdd);
    await getAllUser();
  }

  // Delete Driver function
  Future deleteDriver(String driverId) async {
    await supabase.from("User").delete().eq('id', driverId);
    await supabase.from("Driver").delete().eq('id', driverId);
    await getAllDriver();
  }

  Future deleteTrip(String tripId, Driver driver,) async {
    await supabase.from("Trip").delete().eq('id', tripId);
    int numTrip = 0;
    if(driver.noTrips! != 0 ){
      numTrip = driver.noTrips! - 1;
    }
    await supabase.from("Driver").update({"no_trips": numTrip}).eq('id', driver.id);
  }
  
  // Get Driver Data
  Future getOneDriverData(String driverID) async {
    final data = await supabase.from("Driver").select().eq('id', driverID);
    for (var element in data) {
      locator.driverData = Driver.fromJson(element);      
    }
  }

  // Get trip information
  Future getAllCurrentTrip() async {
    
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc('get_current_supervisor_trips', params: {'supervisorid' : locator.currentUser.id!});
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        Driver driver;
        DarbUser driverData;
        int noOfPassengers = await supabase
            .rpc('get_trip_student_count', params: {'tripid': trip.id});
        final drivers = await supabase.from("User").select().eq('id', trip.driverId).single();
        final driverName = await supabase.from("Driver").select().eq('id', trip.driverId).single();
        driver = Driver.fromJson(driverName);
        driverData = DarbUser.fromJson(drivers);
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverData.name,
          driver: driver,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    locator.supervisorCurrentTrips = tripCardList;
    return tripCardList;
  }


   Future getAllFutureTrip() async {
    
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc('get_future_supervisor_trips', params: {'supervisorid' : locator.currentUser.id!});
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        Driver driver;
        DarbUser driverData;
        int noOfPassengers = await supabase.rpc('get_trip_student_count', params: {'tripid': trip.id});
        final drivers = await supabase.from("User").select().eq('id', trip.driverId).single();
        final driverName = await supabase.from("Driver").select().eq('id', trip.driverId).single();
        driver = Driver.fromJson(driverName);
        driverData = DarbUser.fromJson(drivers);
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverData.name,
          driver: driver,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    locator.supervisorFutureTrips = tripCardList;
    return tripCardList;
  }



  //  Add bus
  Future addBus(Bus bus, String id) async {
    await supabase.from('Bus').insert(bus.toJson());
        await supabase.from('Driver').update({'has_bus': true}).eq('id', id);
  }

  //  Add trip
  Future addTrip(Trip trip,) async {    
    await supabase.from('Trip').insert(trip.toJson());
    await getOneDriverData(trip.driverId);
     int numTrip = 0;
    if(locator.driverData.noTrips! >= 0 ){
      numTrip = locator.driverData.noTrips! + 1;
    }
    await supabase.from("Driver").update({"no_trips": numTrip}).eq('id', trip.driverId);

    await GetOneTrip(trip);
  }
  
  Future updateTrip(Trip trip, ) async {
    await supabase.from("Trip").update({
      'isToSchool': trip.isToSchool, 
      'district': trip.district, 
      'date' : trip.date.toIso8601String(), 
      'time_from' : '${trip.timeFrom.hour}:${trip.timeFrom.minute}', 
      'time_to' : '${trip.timeTo.hour}:${trip.timeTo.minute}', 
      'driver_id': trip.driverId}).eq('id', trip.id!);
    await getAllCurrentTrip();
    await getAllFutureTrip();
  }

  Future GetOneTrip(Trip trip) async {
    int tripId; 
    final data = await supabase.from("Trip").select('id').match({
      'isToSchool': trip.isToSchool, 
      'district': trip.district, 
      'date' : trip.date.toIso8601String(), 
      'time_from' : '${trip.timeFrom.hour}:${trip.timeFrom.minute}', 
      'time_to' : '${trip.timeTo.hour}:${trip.timeTo.minute}', 
      'driver_id': trip.driverId.toString(),
    }).single();
    tripId = data['id'];

    for (var element in locator.students) {      
      await supabase.from("AttendanceList").insert({
        "trip_id" : tripId,
        "student_id": element.id!, 
        "status" : "حضور مؤكد",
      });
    }

  }




  // ------ Add Student -- Connect Student By Supervisor -------------
  // Search for student to connect specific supervisor
  Future SearchForStudentById(String studentId) async {
    List<DarbUser> students = [];
    List<dynamic> std = await supabase.rpc('get_student_without_supervisor',);
    List<Student> studentList = [];
    for (var element in std) {
      studentList.add(Student.fromJson(element));
    }
    for (var element in studentList) {
      if ((element.id!.substring(30, 36)) == studentId) {
        final dataStudent =
            await supabase.from("User").select().eq('id', element.id!).single();

        students.add(DarbUser.fromJson(dataStudent));
      }
    }
    return students;
  }


  // Connect Student to Supervisor
  Future AddStudentToSupervisor(DarbUser student) async {
    if (student.id!.isNotEmpty) {
      return await supabase.rpc('add_student_to_supervisor_by_id', params: {
        'studentid': student.id,
        'supervisorid': locator.currentUser.id
      });
    }
  }



  Future updateStudent(String studentId, String name, String phone) async {
    await supabase
        .from('User')
        .update({'name': name, 'phone': phone}).eq('id', studentId);
    await getAllUser();
  }

  Future updateDriver(String driverId, String name, String phone) async {
    await supabase
        .from('User')
        .update({'name': name, 'phone': phone}).eq('id', driverId);
    await getAllDriver();
  }
 
  Future updateBus(Bus bus,) async {
    await supabase
        .from('Bus')
        .update({'seats_number': bus.seatsNumber, 'bus_plate': bus.busPlate, 'date_issue' : bus.dateIssue.toIso8601String(), 'date_expire' : bus.dateExpire.toIso8601String(), 'driver_id': bus.driverId}).eq('id', bus.id!);
        await supabase.from('Driver').update({'has_bus': true}).eq('id', bus.driverId);
    await getAllBuses();
  }



  //---------------Auth Actions---------------
    Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future signIn({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future signOut() async {
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    return supabase.auth.currentSession;
  }

  Future<String> getCurrentUserId() async {
    return supabase.auth.currentUser!.id;
  }

  Future<DarbUser> getCurrentUserInfo() async {
    return DarbUser.fromJson(await supabase
        .from("User")
        .select()
        .match({"id": await getCurrentUserId()}).single());
  }

  Future<void> addUser(DarbUser user) async {
    await supabase.from("User").insert(user.toJson());
  }

  Future<void> addStudent(Student student) async {
    await supabase.from("Student").insert(student.toJson());
  }

  Future<void> addDriver(Driver driver) async {
    await supabase.from("Driver").insert(driver.toJson());
  }

  Future<void> sendOtp(String email) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp(String otp, String email) async {
    await supabase.auth
        .verifyOTP(type: OtpType.email, token: otp, email: email);
  }

  Future<void> changePassword(String password) async {
    await supabase.auth.updateUser(
      UserAttributes(
        password: password,
      ),
    );
  }

  Future<void> resendOtp(String email) async {
    await sendOtp(email);
  }

  Future<void> updateUserInfo(String name, String phone) async {
    await supabase.from("User").update({'name': name, 'phone': phone}).eq(
        'id', locator.currentUser.id!);
  }

  Future<void> uploadImage(File file) async {
    await supabase.storage
        .from("user_images")
        .upload(locator.currentUser.id!, file);
  }

  Future<void> updateImage(File file) async {
    await supabase.storage
        .from("user_images")
        .update(locator.currentUser.id!, file);
  }

  void getCurrentUserImage() {
    locator.currentUserImage = supabase.storage
        .from("user_images")
        .getPublicUrl(locator.currentUser.id!);
  }

 // Getting current user ID
  Future getCurrentUserID() async {
    final currentUserId = supabase.auth.currentUser?.id;
    return currentUserId;
  }
// -----------------Chat Actions------------------------------------
  // Get messages stream
  Stream<List<Message>> getMessagesStream(int chatId) {
    final Stream<List<Message>> msgStream = supabase
        .from('Message')
        .stream(primaryKey: ["id"])
        .eq('chat_id', chatId)
        .order('created_at')
        .map((messages) => messages
            .map((message) => Message.fromJson(json: message,myUserID: locator.currentUser.id!))
            // Message.fromJson(json: message, myUserID: userID))
            
            .toList());
    return msgStream;
  }

  // Get chat stream 
 Future<Chat> getChatData(int chatId)async {
    final Chat chat = Chat.fromJson(await supabase
        .from('Chat')
        .select()
        .eq("id", chatId)
        .single());
    return chat;
  }

  // Submit message
  Future submitMessage(String msgContent, int chatId) async {
    await supabase.from("Message").insert({
      'user_id': locator.currentUser.id,
      'message': msgContent,
      'chat_id': chatId,
    });
  }

    Future<List<Map<String, dynamic>>> checkChat(String driverId ,String studentId) async{
    List<Map<String, dynamic>> chatIdList = await supabase.from("Chat")
    .select('id')
    .match({
      'driver_id': driverId,
      'student_id': studentId,
    });
    return chatIdList;
  }

  Future createChat(String driverId ,String studentId) async{
    await supabase.from('Chat')
    .insert(Chat(driverId: driverId, studentId: studentId).toJson());
  }

 //---------------------------DRIVER LOCATION Actions ---------------------------
Future<List<Student>> getStudentLocationList(int tripId) async{
  List<Student> studentList = [];
  List<dynamic> studentMap = await supabase.rpc("get_student_location_list",
   params:{
"tripid":tripId
  });
if (studentMap.isNotEmpty) {
  for (var student in studentMap) {
    studentList.add(Student.fromJson(student));
  }
}
return studentList;
}

  //---------------------------Student Actions---------------------------
  Future<Student> getStudentInfo() async {
    return Student.fromJson(await supabase
        .from("Student")
        .select()
        .eq('id', locator.currentUser.id!)
        .single());
  }

  Future<void> updateUserLocation(LatLng coordinates) async {
    await supabase.from("Student").update({
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude
    }).eq('id', locator.currentUser.id!);
  }

  Future<List<TripCard>> getAllStudentTrips() async {
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc(
        'get_student_trips',
        params: {'studentid': locator.currentUser.id});
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        String driverName = "";
        int noOfPassengers = await supabase
            .rpc('get_trip_student_count', params: {'tripid': trip.id});
        Map<String, dynamic> driverNameMap = await supabase
            .from("User")
            .select('name')
            .eq('id', trip.driverId)
            .single();
        driverName = driverNameMap['name'];
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverName,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    return tripCardList;
  }
  //---------------------------Driver Actions---------------------------
  Future<List<TripCard>> getAllDriverTrips() async {
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc('get_driver_trips', params: {'driverid': locator.currentUser.id});
    if(mapTriplist.isNotEmpty){
      for (Map<String, dynamic> tripMap in mapTriplist){
        tripList.add(Trip.fromJson(tripMap));
      }
      for(Trip trip in tripList){
        int noOfPassengers = await supabase.rpc('get_trip_student_count', params: {'tripid': trip.id});
        tripCardList.add(TripCard(trip: trip, driverName: locator.currentUser.name, noOfPassengers: noOfPassengers,));
      }
    }
    return tripCardList;
  }
  //---------------------------Trip Actions---------------------------
  Future<DarbUser> getDriverUserInfo(String driverId) async{
    return DarbUser.fromJson(await supabase
        .from("User")
        .select()
        .match({"id": driverId}).single());

  }

  Future<AttendanceList> getStudentAttendanceStatus(int tripId) async {
    return AttendanceList.fromJson(await supabase.from("AttendanceList").select().match({
      'trip_id': tripId,
      'student_id': locator.currentUser.id
    }).single());
  }

  Future<AttendanceStatus> changeAttendanceStatus(int tripId, AttendanceStatus currentStatus, String? studentId) async {
    if(currentStatus == AttendanceStatus.absent && studentId == null){
      await supabase.from("AttendanceList").update({'status': "حضور مؤكد"}).match({
      'trip_id': tripId,
      'student_id': locator.currentUser.id
    });
      return AttendanceStatus.assueredPrecense;
    }else if (currentStatus == AttendanceStatus.assueredPrecense && studentId == null){
      await supabase.from("AttendanceList").update({'status': "غائب"}).match({
      'trip_id': tripId,
      'student_id': locator.currentUser.id
    });
      return AttendanceStatus.absent;
    }else if (currentStatus == AttendanceStatus.present && studentId != null){
      await supabase.from("AttendanceList").update({'status': "حاضر"}).match({
      'trip_id': tripId,
      'student_id': studentId
    });
    return AttendanceStatus.present;
    }else {
      await supabase.from("AttendanceList").update({'status': "غائب"}).match({
      'trip_id': tripId,
      'student_id': studentId
    });
     return AttendanceStatus.absent;
    }
  }

  //---------------------------AttendanceList Actions---------------------------

  Stream<List<AttendanceList>> getAttendanceList(int tripId) {
    final Stream<List<AttendanceList>> attendanceListStream = supabase
    .from("AttendanceList")
    .stream(primaryKey: ['trip_id'])
    .eq('trip_id', tripId)
    .order('student_id')
    .map((records) => records
    .map((record) => AttendanceList.fromJson(record)).toList());
    return attendanceListStream;
  }

  Future<List<DarbUser>> getTripStudentList(int tripId) async{
    List<DarbUser> studentList = [];
    final List<dynamic> studentListMap = await supabase.rpc('get_trip_student_list', params: {'tripid': tripId});

    for (Map<String, dynamic> student in studentListMap){
      studentList.add(DarbUser.fromJson(student));
    }
    return studentList;
  }

  Future<Location?> checkDriverLocationExist() async{
    List<Map<String, dynamic>> locationMap = await supabase.from("Location").select().eq('user_id', locator.currentUser.id!);
    print(locationMap);
    if(locationMap.isNotEmpty){
      return Location.fromJson(locationMap[0]);
    }else {
      Position driverPos = await Geolocator.getCurrentPosition();
      Map<String, dynamic> locationJson = Location(userId: locator.currentUser.id!, latitude: driverPos.latitude, longitude: driverPos.longitude).toJson();
      await supabase.from("Location").insert(locationJson);
      return null;
    }
  }

  Future<void> createDriverLocationCron(TimeOfDay timeFrom,TimeOfDay timeTo, String driverId) async {
    await locator.driverLocationCron.close();

    locator.driverLocationCron = Cron();

    locator.driverLocationCron.schedule(Schedule.parse('*/2 * * * *'), () async{
      if(locator.isGivenTimeInCurrentTime(timeFrom, timeTo)){
        Position driverPos = await Geolocator.getCurrentPosition();
        await supabase.from("Location").update({
        'latitude': driverPos.latitude,
        'longitude': driverPos.longitude,
      }).eq('user_id', driverId);
      } else {
        await supabase.from("Location").delete().eq('user_id', driverId);
        locator.driverLocationCron.close();
      }
    });
  }
  //---------------------------Trip Location Actions---------------------------

  
  Stream<List<Location>> getTripCurrentDriverLocation(String driverId) {
    return supabase.from('Location')
        .stream(primaryKey: ["user_id"])
        .eq('user_id', driverId).map((locations) => locations.map((location) => Location.fromJson(location)).toList());
  }

  Future<Student> getStudentHomeLocation() async{
    Map<String, dynamic> studentMap = await supabase.from("Student").select().eq('id', locator.currentUser.id!).single();
    print(studentMap);
    return Student.fromJson(studentMap);
  }

}
