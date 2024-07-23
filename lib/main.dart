import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/src/model/data/localization.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/widgets/splash.dart';
void main() {

  runApp( const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Localization(),
      locale: const Locale('vi', 'VN'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color:  Color(blue),
          titleTextStyle: TextStyle(color:  Color(white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
