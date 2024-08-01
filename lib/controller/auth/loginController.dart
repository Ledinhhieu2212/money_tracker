import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_tracker/services/api.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String data = '';

  void getDialogMesssageError({required String error}) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(error),
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
      ),
    );
  }

  void _updateIsLoading(bool currentStatus) {
    isLoading = currentStatus;
    update();
  }

  Future<void> loginWithPhone() async {
    isLoading = true;
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginPhone);
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
        GetOffPage(page: NavigationMenu());
      } else {
        if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
          throw "Không được để chống trường nhập!";
        } else {
          throw jsonDecode(response.body)["Message"] ??
              "Sai thông tin tài khoản";
        }
      }
    } on SocketException catch (error) {
      getDialogMesssageError(error: '$error');
    } on HttpException catch (error) {
      getDialogMesssageError(error: '$error');
    } on FormatException catch (error) {
      getDialogMesssageError(error: '$error');
    } catch (error) {
      getDialogMesssageError(error: error.toString());
    }
  }
}
