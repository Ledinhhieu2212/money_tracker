import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  void changeLanguage(var param1, var param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }

  void ifChangeLanguage({locale = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('locale', locale);
    int sum = prefs.getInt('locale') ?? 0;
    if (sum == 1) {
      changeLanguage('vi', 'VN');
    }
    if (sum == 2) {
      changeLanguage('en', 'US');
    }
  }
}
