import 'package:money_tracker/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user.id);
    prefs.setString('username', user.username);
    prefs.setString('password', user.password);
    prefs.setString('phone', user.phone);
    prefs.setString('email', user.email);
    prefs.setString('token', user.token!);
    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    String phone = prefs.getString('phone') ?? '';
    String email = prefs.getString('email') ?? '';
    String token = prefs.getString('token') ?? '';
    return User(
      id: userId,
      username: username,
      password: password,
      phone: phone,
      email: email,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('phone');
    prefs.remove('email');
    prefs.remove('token');
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<int> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId")!;
  }

  Future<bool> saveTool({required String name, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
    return prefs.commit();
  }

  Future<String> getTool({required String name}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name)!;
  }
}
