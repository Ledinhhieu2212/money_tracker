import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';

class FinancialAnalysis extends StatefulWidget {
  const FinancialAnalysis({super.key});

  @override
  State<FinancialAnalysis> createState() => _FinancialAnalysisState();
}

class _FinancialAnalysisState extends State<FinancialAnalysis> {
  DateTime? _startDate;
  DateTime? _endDate;
  String dattime = '';
  List<Transaction> transactions = [];
  List<Wallet> wallets = [];
  List<PieData> data = [];
  late TransactionService service;
  late WalletService wallertService;
  @override
  void initState() {
    super.initState();
    _setInitialDateRange();
    _connectdatabase();
  }

  void _connectdatabase() async {
    int userId = await UserPreference().getUserID();
    service = TransactionService(await getDatabase());
    wallertService = WalletService(await getDatabaseWallet());
    var data1 = await service.searchOfUser(userId: userId);
    var data2 = await wallertService.searchWallets(userId);
    setState(() {
      transactions = data1.where((element) {
        DateTime date = formatStringToDate(element.dateTime);
        return date.compareTo(_startDate!) >= 0 &&
            date.compareTo(_endDate!) <= 0;
      }).toList();
      wallets = data2;
      data = getDataPie(
        transactions: transactions,
        startTime: _startDate!,
        endTime: _endDate!,
      );
      // List.generate(
      //   data.length,
      //   (index) {
      //     print(data[index].toMap());
      //   },
      // );
    });
  }

  void _setInitialDateRange() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    setState(() {
      _startDate = removeTimeDate(startOfWeek);
      _endDate = removeTimeDate(endOfWeek);
    });
  }

  void _increaseDateRangeByOneWeek({
    required List<Transaction> tr,
    required DateTime start,
    required DateTime end,
  }) {
    setState(() {
      _startDate = start;
      _endDate = end;
      _connectdatabase();
    });
  }

  void _decreaseDateRangeByOneWeek({
    required List<Transaction> tr,
    required DateTime start,
    required DateTime end,
  }) {
    setState(() {
      _startDate = start;
      _endDate = end;
      _connectdatabase();
    });
  }
  // List<PieChartSectionData> getSections() => PieData.data

  List<PieData> getDataPie(
      {required List<Transaction> transactions,
      required DateTime startTime,
      required DateTime endTime}) {
    List<PieData> items = [];
    double incomeTotal = 0, expenseTotal = 0;
    double calculatePercentage(double smallerValue, double largerValue) {
      if (largerValue + smallerValue == 0) {
        return 0;
      }
      return (smallerValue / (largerValue + smallerValue)) * 100;
    }

    incomeTotal = transactions
        .where((tx) => tx.transaction_type == 1)
        .fold(0, (sum, tx) => sum + tx.money);
    expenseTotal = transactions
        .where((tx) => tx.transaction_type == 0)
        .fold(0, (sum, tx) => sum + tx.money);
    items.add(
      PieData(
          name: "Chi tiêu",
          percent: calculatePercentage(expenseTotal, incomeTotal),
          color: Colors.red),
    );
    items.add(
      PieData(
          name: "Thu nhập",
          percent: calculatePercentage(incomeTotal, expenseTotal),
          color: Colors.green),
    );

    return items;
  }

  Widget buildDateRangeSelector({
    required Color color,
    required List<Transaction> tr,
    required DateTime start,
    required DateTime end,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: MaterialButton(
              child: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                _decreaseDateRangeByOneWeek(
                  tr: transactions,
                  start: _startDate!.subtract(const Duration(days: 7)),
                  end: _endDate!.subtract(const Duration(days: 7)),
                );
              },
            ),
          ),
          Flexible(
            flex: 8,
            child: Text(
                "${FormatDateVi(_startDate!)} - ${FormatDateVi(_endDate!)}"),
          ),
          Flexible(
            flex: 1,
            child: Transform.rotate(
              angle: 180 * pi / 180,
              child: MaterialButton(
                child: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  _increaseDateRangeByOneWeek(
                    tr: transactions,
                    start: _startDate!.add(const Duration(days: 7)),
                    end: _endDate!.add(const Duration(days: 7)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(grey),
      appBar: AppBar(
        title: Text("financial_analysis".tr),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            buildDateRangeSelector(
              color: Colors.blue,
              tr: transactions,
              start: _startDate!,
              end: _endDate!,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300, // Đặt chiều rộng mong muốn
              height: 300,
              child: AspectRatio(
                aspectRatio: 1.3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      // sectionsSpace: 0,
                      // centerSpaceRadius: 0,
                      borderData: FlBorderData(show: false),
                      sections: data
                          .asMap()
                          .map<int, PieChartSectionData>((index, d) {
                            final value = PieChartSectionData(
                              color: d.color,
                              value: d.percent,
                              title: '${d.percent.round()}%',
                              titleStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                            return MapEntry(index, value);
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieData {
  final String name;
  final double percent;
  final Color color;
  PieData({
    required this.name,
    required this.percent,
    required this.color,
  });
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'percent': percent.toStringAsFixed(2),
      'color': color,
    };
  }
}
