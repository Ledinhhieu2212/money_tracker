import 'package:flutter/material.dart';
import 'package:money_tracker/model/Styles/colors.dart';
import 'package:money_tracker/src/view/widgets/loading.dart';
import 'package:money_tracker/src/view/widgets/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: blue,
          // backgroundColor: grey,
          titleTextStyle: TextStyle(color: white),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
