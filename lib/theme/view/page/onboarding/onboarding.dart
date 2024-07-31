import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/theme/constants/app_assets.dart';
import 'package:money_tracker/theme/constants/app_color.dart';
import 'package:money_tracker/theme/view/page/login/login.dart';
import 'package:money_tracker/theme/view/page/sign/sign.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor(AppPallete.white),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: getScreenHeight(context) / 2 - 40,
              child: Center(
                child: Image.asset(imageBase.Illustration),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Gain total control of your money",
                style: TextStyle(
                  color: HexColor(AppPallete.dark50),
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                textAlign: TextAlign.center,
                'Become your own money manager and make every cent count',
                style: TextStyle(
                  color: HexColor(AppPallete.light20),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    child: CircleAvatar(
                      backgroundColor: HexColor(AppPallete.violet100),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: CircleAvatar(),
                  ),
                  const SizedBox(
                    height: 20,
                    child: CircleAvatar(),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () => Get.to(const SignUpPage()),
              minWidth: getScreenWidth(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: HexColor(AppPallete.violet100),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 20, color: HexColor(AppPallete.light80)),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () => Get.to(const LoginPage()),
              minWidth: getScreenWidth(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: HexColor(AppPallete.violet20),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20, color: HexColor(AppPallete.violet100)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
