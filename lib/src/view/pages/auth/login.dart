import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker/src/controller/auth/login_controller.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/auth/register.dart';
import 'package:money_tracker/src/view/widgets/button.dart';
import 'package:money_tracker/src/view/widgets/text_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: loginController.phoneController,
              label: "Nhập số điện thoại",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: loginController.passwordController,
              label: "Nhập mật khẩu",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: loginController.loginWithPhone,
              // _login(_phoneController.text, _passwordController.text),
              title: "Đăng nhập",
            ),
          ),
          TextButton(
            onPressed: () => Get.to(RegisterScreen(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 500)),
            child: Text("Đăng ký tài khoản"),
          ),
        ],
      ),
    ));
  }
}
