import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(imageBase()
                .Logo), // Replace with your actual Lottie animation asset path
          )
        ],
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 5), () async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('ten_nguoi_dung');
      GetOffAllPage(
          page: id == null ?  () => LoginScreen() :() =>  NavigationMenu( ));
    });
  }
}
