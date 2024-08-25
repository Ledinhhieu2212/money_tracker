import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/view/widgets/charts/line_chart.dart';

class IncomeAnalysis extends StatefulWidget {
  const IncomeAnalysis({super.key});

  @override
  State<IncomeAnalysis> createState() => _IncomeAnalysisState();
}

class _IncomeAnalysisState extends State<IncomeAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("income_analysis".tr),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: WeekScreen(),
    );
  }

  

}


class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String dattime = '';
  late Transaction transaction;
  List<Transaction> transactions = [];
  late TransactionService service;
  @override
  void initState() {
    super.initState();
    _setInitialDateRange();
    _connectdatabase();
  }

  void _connectdatabase() async {
    int userId = await UserPreference().getUserID();
    service = TransactionService(await getDatabase());
    var data = await service.searchOfUser(userId: userId);
    setState(() {
      transactions =
          data.where((element) => element.transaction_type == 1).toList();
    });
  }

  void _setInitialDateRange() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    setState(() {
      _startDate = startOfWeek;
      _endDate = endOfWeek;
    });
  }

  Future<void> _editDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now(),
        end: _endDate ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(grey),
      child: Column(
        children: [
          MaterialButton(
            onPressed: _editDateRange,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // thay đổi vị trí bóng đổ
                  ),
                ],
              ),
              child: (_startDate != null && _endDate != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Từ ${_startDate!.day}/${_startDate!.month}/${_startDate!.year} "),
                        Text(
                            "Đến ${_endDate!.day}/${_endDate!.month}/${_endDate!.year} "),
                      ],
                    )
                  : const Text("Chọn tuần"),
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: LineChartScreen(
              start: _startDate!,
              end: _endDate!,
              transactions: transactions,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Column(
                          children: [
                            // Text("Ngày: $dattime"),
                            Text("Thông tin giao dịch: "),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}