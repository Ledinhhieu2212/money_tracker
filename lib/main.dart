import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/localization.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/pages/splash/splash.dart';

void main() {
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