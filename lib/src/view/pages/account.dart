import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final styleText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  Widget _totalAmount() {
    return Container(
      height: 50,
      color: const Color(white),
      width: getScreenWidth(context),
      child: const Center(
        child: Text(
          "Tổng tiền: ",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _totalAmountDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      color: const Color(white),
      width: getScreenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Đang sử dụng (0đ)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Transform.rotate(
            angle: 90 * 3.1415926535897932 / 180,
            child: const Icon(
              Icons.chevron_left,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          automaticallyImplyLeading: false,
          title: const Center(
              child: Text(
            "Tài khoản",
            style: TextStyle(fontSize: 20),
          )),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: Color.fromARGB(206, 255, 255, 255),
            mouseCursor: SystemMouseCursors.contextMenu,
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: "TÀI KHOẢN",
              ),
              Tab(
                text: "SỐ TIẾT KIỆM",
              ),
              Tab(
                text: "TÍCH LŨY",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: const Color(grey),
              child: Column(
                children: [
                  _totalAmount(),
                  _totalAmountDetails(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      color: const Color(white),
                      child: const Row(
                        children: [
                          // Image.asset("")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(child: Center(child: Text("Tab 2"))),
            Container(child: Center(child: Text("Tab 3 "))),
          ],
        ),
      ),
    );
  }
}
