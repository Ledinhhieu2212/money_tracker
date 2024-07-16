import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/pages/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _obscureText;
  @override
  void initState() {
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
          text: _obscureText ? '0 ' : "***000 ",
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationPage()),
        );
      },
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Tk: dinhhieu203765',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                padding: const EdgeInsets.symmetric( horizontal: 10),
                color: const Color(white),
                width: getScreenWidth(context),
                height: getScreenHeight(context) / 2,
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tình hình thu chi",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          )
                        ],
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
