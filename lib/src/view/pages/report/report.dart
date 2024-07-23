import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/widgets/box/box_text_icon.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Báo cáo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: const Color(grey),
        width: getScreenWidth(context),
        height: getScreenHeight(context),
        child: const Wrap(
          alignment: WrapAlignment.spaceAround,
          children: <Widget>[
            BoxTextIcon(
              icon: Icon(
                Icons.show_chart,
                color: Colors.blue,
                size: 40,
              ),
              title: "Tài chính hiện tại",
            ),
            BoxTextIcon(
              icon: Icon(
                Icons.ssid_chart,
                color: Colors.green,
                size: 40,
              ),
              title: "Tình hình thu chi",
            ),
            BoxTextIcon(
              icon: Icon(
                Icons.monetization_on,
                color: Colors.red,
                size: 40,
              ),
              title: "Phân tích chi tiêu",
            ),
            BoxTextIcon(
              icon: Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 40,
              ),
              title: "Phân tích thu",
            ),
            BoxTextIcon(
              icon: Icon(
                Icons.checklist,
                color: Colors.orange,
                size: 40,
              ),
              title: "Theo dõi vay nợ",
            ),
            BoxTextIcon(
              icon: Icon(
                Icons.manage_accounts,
                color: Colors.blue,
                size: 40,
              ),
              title: "Đối tượng thu/chi",
            ),
            BoxTextIcon(
              icon: Icon(Icons.calendar_today, color: Colors.greenAccent, size: 40,),
              title: "Chuyến đi/Sự kiện",
            ),
            BoxTextIcon(
              icon: Icon(Icons.pie_chart, color: Colors.purpleAccent, size: 40,),
              title: "Phân tích tài chính",
            ),
          ],
        ),
      ),
    );
  }
}
