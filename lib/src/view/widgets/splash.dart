import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/auth/login.dart';
import 'package:money_tracker/src/view/widgets/navigation_menu.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString('ma_nguoi_dung') == null
          ? Get.offAll(const LoginScreen())
          : Get.offAll(NavigationMenu(preferences: prefs));
    });
  }
}
