import 'package:get/get.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/services/user_service.dart';

class UserController extends GetxController {
  late User user;

  Future<User> GetUser(int id) async {
    UserService userService = UserService(await getDataUser());
    var data = await userService.getById(id);
    return data;
  }
}
