import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/view/pages/report/widgets/expense_analysis.dart';
import 'package:money_tracker/view/pages/report/widgets/expense_income.dart';
import 'package:money_tracker/view/pages/report/widgets/financial_analysis.dart';
import 'package:money_tracker/view/pages/report/widgets/income_analysis.dart';
import 'package:money_tracker/view/widgets/box/box_text_icon.dart'; 

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
              onPress: () {
                getToPage(page: () => ExpenseAnalysis());
              },
              icon: const Icon(
                Icons.monetization_on,
                color: Colors.red,
                size: 40,
              ),
              title: "expense_analysis".tr,
            ),
            BoxTextIcon(
              onPress: () {
                getToPage(page: () => IncomeAnalysis());
              },
              icon: const Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 40,
              ),
              title: "income_analysis".tr,
            ),
            BoxTextIcon(
              onPress: () {
                getToPage(page: () => ExpenseIncome());
              },
              icon: const Icon(
                Icons.ssid_chart,
                color: Colors.green,
                size: 40,
              ),
              title: "expense_income".tr,
            ),
            BoxTextIcon(
              onPress: () {
                getToPage(page: () => FinancialAnalysis());
              },
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
