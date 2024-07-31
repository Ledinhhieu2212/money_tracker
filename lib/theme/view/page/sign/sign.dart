import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/theme/constants/app_color.dart';
import 'package:money_tracker/theme/view/page/login/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Sign Up",
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
                  hintText: "Name",
                  hintStyle: TextStyle(color: HexColor(AppPallete.light20))),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: HexColor(AppPallete.violet100),
                  ),
                ),
                Flexible(
                  flex: 9,
                  child: TextButton(
                    onPressed: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text.rich(
                        style: TextStyle(fontSize: 15),
                        TextSpan(
                            text: "By signing up, you agree to the ",
                            children: [
                              TextSpan(
                                  text: "Terms of Service and Privacy Policy",
                                  style: TextStyle(
                                      color: HexColor(AppPallete.violet100)))
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            MaterialButton(
              onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Or with",
                style: TextStyle(
                    color: HexColor(AppPallete.light20),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                    color: HexColor(AppPallete.light60),
                    width: 2.0), // Border color and width
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
                    "Sign Up with Google",
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
            const SizedBox(height: 15),
            Text.rich(
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: HexColor(AppPallete.light20)),
                children: [
                  TextSpan(
                    text: 'Login',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(const LoginPage());
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
