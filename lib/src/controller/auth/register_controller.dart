import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/view/pages/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var errorMessage = '';
 

  Future<void> registerWithPhone() async {
    try {
      var url = Uri.parse("http://qltcapi.tasvietnam.vn/api/user/Register");
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'ten_nguoi_dung': nameController.text,
          'soDienThoai': phoneController.text,
          'Password': passwordController.text
        }),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        nameController.clear();
        phoneController.clear();
        passwordController.clear();
        Get.off(const LoginScreen(),
            transition: Transition.leftToRight,
            duration: const Duration(seconds: 1));
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Stack(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thông báo',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Đăng ký tài khoản thành công"),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back(); // Đóng dialog khi nhấn nút "X"
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        if (phoneController.text.isEmpty ||
            passwordController.text.isEmpty ||
            phoneController.text.isEmpty) {
          throw "Không được để chống trường nhập!";
        } else if (phoneController.text.isNumericOnly) {
          throw "Trường số điện thoại chỉ cho phép nhập số";
        } else {
          throw jsonDecode(response.body)["Message"] ??
              "Sai thông tin tài khoản";
        }
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lỗi',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(e.toString()),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back(); // Đóng dialog khi nhấn nút "X"
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
