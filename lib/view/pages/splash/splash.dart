import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

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
            child: LottieBuilder.asset(imageBase().Logo),
          )
        ],
      ),
    );
  }

  void navigate() {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        String? token = await UserPreference().getToken();
        
        getToPage(
          page:  token == null
          ? () => const LoginScreen()
          : () => const NavigationMenu());
      },
    );
  }
}
