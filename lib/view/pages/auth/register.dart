import 'package:flutter/material.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/controller/auth/registerController.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/view/widgets/button.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/constants/app_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerationController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    double  h= 15;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
           SizedBox(height: h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: textFormFieldAuth(
              controller: registerationController.phoneController,
              label: "text_auth_phone".tr,
            ),
          ),
           SizedBox(height: h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: textFormFieldAuth(
              controller: registerationController.nameController,
              label: "text_auth_username".tr,
            ),
          ),
           SizedBox(height: h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: textFormFieldAuth(
              controller: registerationController.passwordController,
              label: "text_auth_password".tr,
              obscureTextBool: true,
            ),
          ),
           SizedBox(height: h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: registerationController.registerWithPhone,
              title: "signout".tr,
            ),
          ),
           SizedBox(height: h),
          TextButton(
            onPressed: () => getToPage(page: const LoginScreen()),
            child: Text("link_login_account".tr),
          ),
        ],
      )),
    );
  }
}
