import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  String? username;
  String? price;

 dynamic HomeUser({required SharedPreferences preferences}) {
    username = preferences.getString('ten_nguoi_dung') ?? '';
    price = preferences.getString('so_du') ?? '';
  }
}
