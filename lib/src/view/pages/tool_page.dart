import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/login.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:  Color(white),
        flexibleSpace: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            child: Row(
              children: [],
            ),
          ),
        ),
      ),
      body: Container(
        color:  Color(grey),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(white),
                shadowColor: null,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                // Handle button press event here
                print('Button pressed');
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.settings,
                        color:  Color(white),
                        size: 30,
                      )),
                  Container(width: 300, child: Text("Cài đặt chung")),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(white),
                shadowColor: null,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.logout,
                        color:  Color(white),
                        size: 20,
                      )),
                  const SizedBox(width: 340, child: Text("Đăng xuất")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
