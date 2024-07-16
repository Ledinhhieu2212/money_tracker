import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/login.dart';
import 'package:money_tracker/src/view/utils/routers.dart';

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
      body: Center(
        child: Image.asset(imageBase().Logo),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      PageNavigator(ctx: context).nextPageOnly(page: const LoginScreen());
    });
  }
}
