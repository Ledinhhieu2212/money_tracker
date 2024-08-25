import 'dart:io'; 
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/localization.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/pages/splash/splash.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async  {
  // if (Platform.isWindows || Platform.isLinux) {
  //   // Initialize FFI
  //   sqfliteFfiInit();
  // }
  // // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // // this step, it will use the sqlite version available on the system.
  // databaseFactory = databaseFactoryFfi;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Localization(),
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('vi', 'VN'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(blue),
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}