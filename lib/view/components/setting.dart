import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/controller/controller.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/widgets/category/catgory_between_right_text_config_app.dart';
import 'package:money_tracker/view/components/splash.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cài đặt chung",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: const Color(grey),
        width: getScreenWidth(context),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "HIỂN THỊ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  )),
            ),
            CatgoryBetweenConfigApp(
              onTap: () => Get.to(SelectLanguage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              title: "Ngôn ngữ",
              titleConfig: "Tiếng Việt",
            ),
            CatgoryBetweenConfigApp(
              onTap: () => Get.to(SelectDateTime(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              title: "Định dạng thời gian",
              titleConfig: "dd/MM/yyyy",
            ),
            CatgoryBetweenConfigApp(
              onTap: () => Get.to(SelectCurrency(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              title: "Thiết lập tiền tệ",
              titleConfig: "VND",
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SelectLanguage extends StatefulWidget {
   const SelectLanguage({super.key});
  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  Controller controllerChange = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chọn ngôn ngữ"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
                controllerChange.changeLanguage('vi', 'VN');
                Get.to(const SplashScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 70,
                      width: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        imageBase().vietname,
                        alignment: Alignment.center,
                      )),
                  const Column(
                    children: [
                      Text(
                        "Tiếng Việt",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text("Tiếng Việt")
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
                controllerChange.changeLanguage('en', 'US');//en_US 
                Get.to(const SplashScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 70,
                      width: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        imageBase().usa,
                        alignment: Alignment.center,
                      )),
                  const Column(
                    children: [
                      Text(
                        "English",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text("Tiếng Anh")
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({super.key});

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chọn định dạng thời gian"),
        ),
        body: Container());
  }
}

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chọn định dạng thời gian"),
      ),
      body: Container(),
    );
  }
}
