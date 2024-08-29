import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/controller/auth/loginController.dart';
import 'package:money_tracker/view/pages/auth/register.dart';
import 'package:money_tracker/controller/controller.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/widgets/button.dart'; 
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
        body: Stack(
          children: [
            GetBuilder<LoginController>(builder: (_) {
              return loginController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      child: Form(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
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
                              const SizedBox(
                                height: 20,
                              ),
                              textFormFieldAuth(
                                controller: loginController.phoneController,
                                label: "text_auth_phone".tr,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textFormFieldAuth(
                                controller: loginController.passwordController,
                                label: "text_auth_password".tr,
                                obscureTextBool: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ButtonCustom(
                                onPressed: loginController.loginWithPhone,
                                title: "signin".tr,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () =>
                                    getToPage(page: const RegisterScreen()),
                                child: Text("link_register_account".tr),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }),
          ],
        ));
  }
}
