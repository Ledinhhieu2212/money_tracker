import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/widgets/notification.dart';
import 'package:money_tracker/view/widgets/setting.dart';
import 'package:money_tracker/view/pages/auth/login.dart';
import 'package:money_tracker/view/widgets/button/button_tool_setting_no_right_icon.dart';
import 'package:money_tracker/view/widgets/button/button_tool_setting_right_icon.dart';
import 'package:get/get.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<ToolPage> createState() => _ToolPageState();
}

class _ToolPageState extends State<ToolPage> {
  User? user;
  void resetToken() async {
    UserPreference().removeUser();
  }

  logOut() {
    resetToken();
    getOffAllPage(page: () => const LoginScreen());
  }

  getUser() async {
    var u = await UserPreference().getUser();
    setState(() {
      user = u;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(grey),
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: const Color(blue),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () {},
                child: user == null
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(white),
                            child: Image.asset(imageBase().internet),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tài khoản: ${user!.username}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
              ),
            ),
            ButtonToolSettingRightIcon(
                icon: const Icon(
                  Icons.settings,
                  color: Color(white),
                ),
                onPressed: () => getToPage(page: SettingScreen()),
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
