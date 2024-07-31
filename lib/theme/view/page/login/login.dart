import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/theme/constants/app_color.dart';
import 'package:money_tracker/theme/view/page/sign/sign.dart';
import 'package:money_tracker/theme/view/page/navigation/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor(AppPallete.light60), width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor(AppPallete.violet100), width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(color: HexColor(AppPallete.light20))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor(AppPallete.light60), width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor(AppPallete.violet100), width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: HexColor(AppPallete.light20))),
            ),
            const SizedBox(height: 40),
            MaterialButton(
              onPressed: () => Get.to(const NavigationMenu()),
              minWidth: getScreenWidth(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: HexColor(AppPallete.violet100),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20, color: HexColor(AppPallete.light80)),
              ),
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    color: HexColor(
                      AppPallete.violet100,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),
            MaterialButton(
              onPressed: () {},
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side:
                    BorderSide(color: HexColor(AppPallete.light60), width: 2.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Login with Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor(AppPallete.dark50),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text.rich(
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              TextSpan(
                text: "Don’t have an account yet? ",
                style: TextStyle(color: HexColor(AppPallete.light20)),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(const SignUpPage());
                      },
                    style: TextStyle(
                      color: HexColor(AppPallete.violet100),
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
