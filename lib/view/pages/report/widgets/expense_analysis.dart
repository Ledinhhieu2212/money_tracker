import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/widgets/charts/line_chart.dart';

class ExpenseAnalysis extends StatefulWidget {
  const ExpenseAnalysis({super.key});

  @override
  State<ExpenseAnalysis> createState() => _ExpenseAnalysisState();
}

class _ExpenseAnalysisState extends State<ExpenseAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("expense_analysis".tr),
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
  Transaction? transaction;
  List<Transaction> transactions = [];
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
    wallertService =  WalletService(await getDatabaseWallet());
    var data = await service.searchOfUser(userId: userId);
    setState(() {
      transactions =
          data.where((element) => element.transaction_type == 0).toList();
      transaction = transactions.first;
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
                  color: Colors.red,
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
              child: transaction == null
                  ? const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Chưa có giao dịch chi tiêu trong tuần này!",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Text(
                            "Thông tin giao dịch: ",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Row(
                            children: [
                              Flexible(
                                child:  Image.asset(imageBase().getIconWallets()[0]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
