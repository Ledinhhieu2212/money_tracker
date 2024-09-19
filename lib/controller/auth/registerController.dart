import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/services/api.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();
  UserPreference userPreference = UserPreference();
  var errorMessage = '';
  bool isLoading = false;

  var phoneError = ''.obs;
  var usernameError = ''.obs;
  var passwordError = ''.obs;
  var rePasswordError = ''.obs;
  var titleError = ''.obs;

  bool isValidPhoneNumber(String phone) {
    // Kiểm tra số điện thoại có 10 chữ số và bắt đầu bằng '0'
    return RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$').hasMatch(phone);
  }

  bool isValidPassword(String password) {
    // Kiểm tra mật khẩu chứa ít nhất 1 chữ cái viết hoa, 1 chữ cái viết thường, 1 số, 1 ký tự đặc biệt và có độ dài tối thiểu 8 ký tự
    return RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%\^&\*])[A-Za-z\d!@#\$%\^&\*]{8,}$')
        .hasMatch(password);
  }

  void _updateIsLoading(bool currentStatus) {
    isLoading = currentStatus;
    update();
  }

  void createUser(var body) async {
    final json = jsonDecode(body);
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
    UserPreference userPreference = UserPreference();
    userPreference.saveUser(user);
    phoneController.clear();
    passwordController.clear();
    getOffPage(page: () => const NavigationMenu());
  }

  Future<http.Response> registerApi() async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerPhone);
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
    return response;
  }

  Future<http.Response> searchApi() async {
    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginPhone);
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
    return response;
  }

  Future<void> registerWithPhone() async {
    // Kiểm tra số điện thoại
    if (phoneController.text.isEmpty) {
      phoneError.value = "Không để trống trường số điện thoại ";
    } else if (!isValidPhoneNumber(phoneController.text) &&
        phoneController.text.isNotEmpty) {
      phoneError.value = "Vui lòng nhập số điện thoại hợp lệ";
    }

    // Kiểm tra mật khẩu
    if (passwordController.text.isEmpty) {
      passwordError.value = "Không để trống trường mật khẩu";
    }

    // Kiểm tra trường nhập lại mật khẩu
    if (re_passwordController.text.isEmpty) {
      rePasswordError.value = "Không để trống trường nhập lại mật khẩu";
    } else if (re_passwordController.text != passwordController.text) {
      rePasswordError.value = "Mật khẩu nhập lại không giống mật khẩu đăng ký";
      re_passwordController.clear();
      passwordController.clear();
    }

    // Kiểm tra tên tài khoản
    if (nameController.text.isEmpty) {
      usernameError.value = "Không để trống trường tài khoản";
    }

    // Nếu có lỗi thì dừng lại, không tiếp tục đăng ký
    if (phoneError.isNotEmpty ||
        passwordError.isNotEmpty ||
        rePasswordError.isNotEmpty ||
        usernameError.isNotEmpty) {
      return;
    }

    _updateIsLoading(true);
    try {
      http.Response rs = await registerApi();
      http.Response res = await searchApi();

      if (rs.statusCode == 200) {
        if (res.statusCode == 200) {
          createUser(res.body);
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
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          titleError.value = 'Lỗi! Không đăng ký được tài khoản.';
        }

        phoneError.value = "";
        usernameError.value = '';
        passwordError.value = '';
        rePasswordError.value = '';
        nameController.clear();
        phoneController.clear();
        passwordController.clear();
        re_passwordController.clear();
      } else if (rs.statusCode == 409) {
        titleError.value = 'Tài khoản này đã đăng ký, vui lòng dùng tài khoản khác!';
      }
    } catch (error) {
      getDialogMesssageError(error: error.toString());
    } finally {
      _updateIsLoading(false);
    }
  }

  void getDialogMesssageError({
    required String error,
  }) {
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
}
