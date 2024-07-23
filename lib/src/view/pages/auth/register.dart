import 'package:flutter/material.dart';
import 'package:money_tracker/src/controller/auth/register_controller.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/auth/login.dart';
import 'package:money_tracker/src/view/widgets/button.dart';
import 'package:money_tracker/src/view/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';

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
      body: Form(
          child: Column(
        children: [
          Container(
            height: getScreenHeight(context) / 2,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: LottieBuilder.asset(
                imageBase().Logo,
                repeat: false,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: registerationController.phoneController,
              label: "Nhập số ĐT",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: registerationController.nameController,
              label: "Nhập tên tài khoản",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: registerationController.passwordController,
              label: "Nhập mật khẩu",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: registerationController.registerWithPhone,
              title: "Sign up",
            ),
          ),
          TextButton(
            onPressed: () => Get.to(LoginScreen(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500)),
            child: Text("Login on account"),
          ),
        ],
      )),
    );
  }
}
