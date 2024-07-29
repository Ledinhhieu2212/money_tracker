import 'package:money_tracker/controller/auth/loginController.dart';
import 'package:money_tracker/view/pages/auth/register.dart';
import 'package:money_tracker/controller/controller.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/widgets/button.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  Controller controllerChange = Get.put(Controller());
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controllerChange.ifChangeLanguage(locale: 2);
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(imageBase().usa),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controllerChange.ifChangeLanguage(locale: 1);
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(imageBase().vietname),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Form(
          child: Column(
            children: [
              Container(
                height: getScreenHeight(context) / 3,
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: LottieBuilder.asset(
                    imageBase().Logo,
                    repeat: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textFormFieldAuth(
                  controller: loginController.phoneController,
                  label: "text_auth_phone".tr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textFormFieldAuth(
                  controller: loginController.passwordController,
                  label: "text_auth_password".tr,
                  obscureTextBool: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonCustom(
                  onPressed: loginController.loginWithPhone,
                  title: "signin".tr,
                ),
              ),
              TextButton(
                onPressed: () => GetToPage(page: const RegisterScreen()),
                child: Text("link_register_account".tr),
              ),
            ],
          ),
        ));
  }
}
