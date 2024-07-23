import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:money_tracker/src/controller/home_controller.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/components/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final SharedPreferences preferences;
  const HomeScreen({super.key, required this.preferences});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  var _obscureText;
  @override
  void initState() {
    setState(() {
      homeController.HomeUser(preferences: widget.preferences);
    });
    super.initState();
    _obscureText = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildTextTotalPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: _obscureText ? "${homeController.price} " : "***000 ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(primary), fontSize: 30),
          children: const <TextSpan>[
            TextSpan(
              text: 'đ',
              style: TextStyle(
                  color: Color(primary),
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buitlTextSpending() {
    return RichText(
      text: TextSpan(
          text: "Chi tiêu: ${_obscureText ? '0 ' : "***000 "}",
          style: const TextStyle(color: Colors.red),
          children: const [
            TextSpan(
              text: 'đ',
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
          ]),
    );
  }

  Widget buitlTextComein() {
    return RichText(
      text: TextSpan(
        text: "Thu nhập: ${_obscureText ? '0 ' : "***000 "}",
        style: const TextStyle(color: Colors.green),
        children: const [
          TextSpan(
            text: 'đ',
            style: TextStyle(
              color: Colors.green,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVisibilityButton() {
    return Column(
      children: [
        IconButton(
            padding: const EdgeInsets.all(8.0),
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)),
      ],
    );
  }

  Widget _buildContainterPrice({
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => Get.to(const NotificationPage()),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(white), // Màu nền của Container
          borderRadius:
              BorderRadius.circular(12.0), // Bo tròn góc của Container
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextTotalPrice(),
                buitlTextSpending(),
                buitlTextComein(),
              ],
            ),
            buildVisibilityButton()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${'hello'.tr} ${homeController.username}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cloud_sync),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: _buildContainterPrice(context: context),
        ),
      ),
      body: Container(
        color: const Color(grey),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: getScreenWidth(context),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chi tiêu:"),
                          Text(
                            "Thu nhập:",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(imageBase().food)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Ăn uống",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "-120.000 đ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(imageBase().coffee)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Cafe",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "-15.000 đ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(imageBase().internet)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Lương",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "+2.000.000 đ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
