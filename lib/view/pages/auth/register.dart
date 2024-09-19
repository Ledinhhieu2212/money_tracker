import 'package:flutter/material.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/controller/auth/registerController.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/view/widgets/button/button.dart';
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

  Widget messageError({required RxString text}) {
    return Obx(() => text.isNotEmpty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
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
    double h = 15;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GetBuilder<RegisterController>(
              builder: (_) {
                return registerationController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
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

                          messageError(
                              text: registerationController.titleError),
                          SizedBox(height: h),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: textFormFieldAuth(
                              controller:
                                  registerationController.phoneController,
                              label: "text_auth_phone".tr,
                            ),
                          ),
                          // Hiển thị lỗi cho số điện thoại
                          messageError(
                              text: registerationController.phoneError),
                          SizedBox(height: h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: textFormFieldAuth(
                              controller:
                                  registerationController.nameController,
                              label: "text_auth_username".tr,
                            ),
                          ),
                          // Hiển thị lỗi cho tài khoản
                          messageError(
                              text: registerationController.usernameError),
                          SizedBox(height: h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: textFormFieldAuth(
                              controller:
                                  registerationController.passwordController,
                              label: "text_auth_password".tr,
                              obscureTextBool: true,
                            ),
                          ),
                          // Hiển thị lỗi cho mật khẩu
                          messageError(
                              text: registerationController.passwordError),
                          SizedBox(height: h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: textFormFieldAuth(
                              controller:
                                  registerationController.re_passwordController,
                              label: "Nhập lại mật khẩu",
                              obscureTextBool: true,
                            ),
                          ),
                          // Hiển thị lỗi cho nhập lại mật khẩu
                          messageError(
                              text: registerationController.rePasswordError),
                          SizedBox(height: h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ButtonCustom(
                              onPressed: () {
                                registerationController.phoneError.value = "";
                                registerationController.usernameError.value =
                                    '';
                                registerationController.passwordError.value =
                                    '';
                                registerationController.rePasswordError.value =
                                    '';
                                registerationController.registerWithPhone();
                              },
                              title: "signout".tr,
                            ),
                          ),
                          SizedBox(height: h),
                          TextButton(
                            onPressed: () {
                              getToPage(page: () => const LoginScreen());
                              registerationController.phoneError.value = "";
                              registerationController.usernameError.value = '';
                              registerationController.passwordError.value = '';
                              registerationController.rePasswordError.value =
                                  '';
                              registerationController.nameController.clear();
                              registerationController.phoneController.clear();
                              registerationController.passwordController
                                  .clear();
                              registerationController.re_passwordController
                                  .clear();
                            },
                            child: Text("link_login_account".tr),
                          ),
                        ],
                      ));
              },
            )
          ],
        ),
      ),
    );
  }
}
