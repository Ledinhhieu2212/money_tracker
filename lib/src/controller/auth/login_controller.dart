import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:money_tracker/src/model/api/api.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/model/user.dart';
import 'package:money_tracker/src/view/pages/home/home.dart';
import 'package:money_tracker/src/view/widgets/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); 

  

  Future<void> loginWithPhone() async {
    try {
      var url = Uri.parse("http://qltcapi.tasvietnam.vn/api/user/login");
      // var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginPhone);
      // print(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginPhone);
      
      
      
      
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'SoDienThoai': phoneController.text.trim(),
          'Password': passwordController.text.trim(),
        }),
      );

      
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'ma_nguoi_dung', json['ma_nguoi_dung'].toString());
        await prefs.setString('so_du', json['so_du'].toString());
        await prefs.setString('ten_nguoi_dung', json['ten_nguoi_dung']);
        phoneController.clear();
        passwordController.clear();
        Get.offAll(
            NavigationMenu(
              preferences: prefs,
            ),
            transition: Transition.leftToRight,
            duration: const Duration(seconds: 1));
      } else {
        if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
          throw "Không được để chống trường nhập!";
        } else {
          throw jsonDecode(response.body)["Message"] ??
              "Sai thông tin tài khoản";
        }
      }
    } catch (error) {
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
                      child: Text(error.toString()),
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
