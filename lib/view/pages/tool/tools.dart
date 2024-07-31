import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/components/notification.dart';
import 'package:money_tracker/view/components/setting.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/widgets/button/button_tool_setting_no_right_icon.dart';
import 'package:money_tracker/widgets/button/button_tool_setting_right_icon.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({super.key});

  void deleteLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  logOut() {
    deleteLogin();
    GetOffAllPage(page: const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(blue),
        flexibleSpace: Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(grey),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Row(children: [
                IconButton(
                  onPressed: () => GetToPage(page: NotificationPage()),
                  icon: const Icon(Icons.notifications, color: Colors.white,),
                )
              ])
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(grey),
        child: Column(
          children: [
            ButtonToolSettingRightIcon(
                icon: const Icon(
                  Icons.settings,
                  color: Color(white),
                ),
                onPressed: () => GetToPage(page: SettingScreen()),
                title: "setting".tr,
                backgroundIcon: Colors.purpleAccent),
            ButtonToolSettingNoRightIcon(
                icon: const Icon(
                  Icons.logout,
                  color: Color(white),
                ),
                onPressed: logOut,
                title: "logout".tr,
                backgroundIcon: Colors.grey)
          ],
        ),
      ),
    );
  }
}
