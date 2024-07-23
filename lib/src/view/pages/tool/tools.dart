import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/components/notification.dart';
import 'package:money_tracker/src/view/components/setting.dart';
import 'package:money_tracker/src/view/pages/auth/login.dart';
import 'package:money_tracker/src/view/widgets/button/button_tool_setting_no_right_icon.dart';
import 'package:money_tracker/src/view/widgets/button/button_tool_setting_right_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ToolPage extends StatelessWidget {
  final SharedPreferences pref;
  const ToolPage({super.key, required this.pref});

  logOut() {
    pref.clear();
    Get.offAll(const LoginScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(white),
        flexibleSpace: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )
                  ],
                ),
                Row(children: [
                  IconButton(
                    onPressed: () => Get.to(const NotificationPage(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(seconds: 1)),
                    icon: const Icon(Icons.notifications),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(grey),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ButtonToolSettingRightIcon(
                icon: const Icon(
                  Icons.settings,
                  color: Color(white),
                ),
                onPressed: () => Get.to(const SettingScreen(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500)),
                title: "Cài đặt chung",
                backgroundIcon: Colors.purpleAccent),
            ButtonToolSettingNoRightIcon(
                icon: const Icon(
                  Icons.logout,
                  color: Color(white),
                ),
                onPressed: logOut,
                title: "Đăng xuất",
                backgroundIcon: Colors.grey)
          ],
        ),
      ),
    );
  }
}
