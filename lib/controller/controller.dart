import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/services/share_preference.dart';

class Controller extends GetxController {
  void changeLanguage(String langCode, String countryCode) {
    var locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
  }

  void ifChangeLanguage({int locale = 0}) async {
    UserPreference prefs = UserPreference();
    await prefs.saveTool(name: "locale", value: locale.toString());
    String? sum = await prefs.getTool(name: 'locale');
    if (sum == '0') {
      changeLanguage('vi', 'VN');
    } else if (sum == '1') {
      changeLanguage('en', 'US');
    } else {
      // Ngôn ngữ mặc định nếu không có giá trị hợp lệ
      changeLanguage('vi', 'VN');
    }
  }
}
