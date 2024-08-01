import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/widgets/box/box_text_icon.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "report".tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: const Color(grey),
        width: getScreenWidth(context),
        height: getScreenHeight(context),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: <Widget>[
            BoxTextIcon(
              icon: const Icon(
                Icons.show_chart,
                color: Colors.blue,
                size: 40,
              ),
              title: "financial_statement".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.ssid_chart,
                color: Colors.green,
                size: 40,
              ),
              title: "expense_income".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.monetization_on,
                color: Colors.red,
                size: 40,
              ),
              title: "expense_analysis".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 40,
              ),
              title: "income_analysis".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.checklist,
                color: Colors.orange,
                size: 40,
              ),
              title: "moneny_lent_borrowed".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.manage_accounts,
                color: Colors.blue,
                size: 40,
              ),
              title: "payee_payer".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.greenAccent,
                size: 40,
              ),
              title: "event".tr,
            ),
            BoxTextIcon(
              icon: const Icon(
                Icons.pie_chart,
                color: Colors.purpleAccent,
                size: 40,
              ),
              title: "financial_analysis".tr,
            ),
          ],
        ),
      ),
    );
  }
}
