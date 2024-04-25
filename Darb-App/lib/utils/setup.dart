import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/main.dart';
import 'package:darb_app/pages/Start%20Pages/disconnected_page.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future databaseSetup() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
      url: dotenv.env["supabaseUrl"]!,
      anonKey: dotenv.env["supabaseAnonKey"]!,
      );
}

Future setup() async {
  await GetStorage.init();
  
  GetIt.I.registerSingleton<HomeData>(HomeData());
  GetIt.I.registerSingleton<DBService>(DBService());

}

Future<void> checkConnectionSetup() async{
  InternetConnection().onStatusChange.listen((status) async{
    if (status == InternetStatus.connected){
      runApp(const MainApp());
    }else {
      runApp(const DisconnectedPage());
    }
   });
}