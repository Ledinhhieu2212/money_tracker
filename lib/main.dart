import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/localization.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/controller/controller.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/pages/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Controller
  final controller = Get.put(Controller());

  // Đặt ngôn ngữ ứng dụng dựa trên sở thích đã lưu
  controller.ifChangeLanguage();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Localization(),
      locale: Get.locale,
      fallbackLocale:  Get.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(blue),
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
