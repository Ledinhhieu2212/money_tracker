import 'package:flutter/material.dart';
import 'package:money_tracker/controller/auth/registerController.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/widgets/button.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/widgets/text_field.dart';
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
                onTap: () {},
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(imageBase().usa),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
              controller: registerationController.phoneController,
              label: "text_auth_phone".tr,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: textFormFieldAuth(
              controller: registerationController.nameController,
              label: "text_auth_username".tr,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: textFormFieldAuth(
              controller: registerationController.passwordController,
              label: "text_auth_password".tr,
              obscureTextBool: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: registerationController.registerWithPhone,
              title: "signout".tr,
            ),
          ),
          TextButton(
            onPressed: () => GetToPage(page: const LoginScreen()),
            child:  Text("link_login_account".tr),
          ),
        ],
      )),
    );
  }
}
