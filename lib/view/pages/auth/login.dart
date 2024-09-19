import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/controller/auth/loginController.dart';
import 'package:money_tracker/view/pages/auth/register.dart';
import 'package:money_tracker/controller/controller.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/widgets/button/button.dart';
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
  Widget messageError({required RxString text}) {
    return Obx(() => text.isNotEmpty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 0),
            child: Text(
              textAlign: TextAlign.left,
              text.value,
              style: TextStyle(color: Colors.red),
            ),
          )
        : SizedBox.shrink());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              GetBuilder<LoginController>(builder: (_) {
                return loginController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
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
                              messageError(text: loginController.titleError),
                              const SizedBox(height: 20),
                              textFormFieldAuth(
                                controller: loginController.phoneController,
                                label: "text_auth_phone".tr,
                              ),
                              messageError(text: loginController.phoneError),
                              const SizedBox(height: 20),
                              textFormFieldAuth(
                                controller: loginController.passwordController,
                                label: "text_auth_password".tr,
                                obscureTextBool: true,
                              ),
                              messageError(text: loginController.passwordError),
                              const SizedBox(height: 20),
                              ButtonCustom(
                                onPressed: () {
                                  loginController.phoneError.value = '';
                                  loginController.passwordError.value = '';
                                  loginController.loginWithPhone();
                                },
                                title: "signin".tr,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  loginController.phoneError.value = '';
                                  loginController.passwordError.value = '';
                                  loginController.titleError.value = '';
                                  loginController.passwordController.clear();
                                  loginController.phoneController.clear();
                                  getToPage(page: () => const RegisterScreen());
                                },
                                child: Text("link_register_account".tr),
                              ),
                            ],
                          ),
                        ),
                      );
              }),
            ],
          ),
        ));
  }
}
