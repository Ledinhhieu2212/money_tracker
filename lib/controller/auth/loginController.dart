import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/services/api.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/user_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';  

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserPreference userPreference = UserPreference();
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
    _updateIsLoading(true);
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
      await Future.delayed(Duration(seconds: 3));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        User user = User(
          id: json['ma_nguoi_dung'],
          username: json['ten_nguoi_dung'],
          phone: json['soDienThoai'],
          email: json['email'] ?? '',
          password: json['password'],
          token: utf8
              .encode(json['ma_nguoi_dung'].toString() +
                  json['ten_nguoi_dung'] +
                  json['password'])
              .toString(),
        );
        UserService userService = UserService(await getDataUser());
        if (await userService.idExists(user.id) == false) {
          userService.insert(user);
          userPreference.saveUser(user);
        }
        phoneController.clear();
        passwordController.clear();
        getOffPage(page: () => const NavigationMenu());
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
    } finally {
      _updateIsLoading(false);
    }
  }
}
