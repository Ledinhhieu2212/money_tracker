import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
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
  List<Transaction> transactions = [];
  List<Wallet> wallets = [];
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
      transactions = data1
          .where((element) => element.transaction_type == 0)
          .where((element) {
        DateTime date = formatStringToDate(element.dateTime);
        return date.compareTo(_startDate!) >= 0 &&
            date.compareTo(_endDate!) <= 0;
      }).toList();
      wallets = data2;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(grey),
      child: Column(
        children: [
          Container(
            height: 50, 
            width: double.infinity,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                    angle: 180 * math.pi / 180,
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
          ),
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.only(top: 30, left: 10, right: 15, bottom: 10),
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
          TransactionExpense(tr: transactions, wl: wallets),
        ],
      ),
    );
  }
}

class TransactionExpense extends StatelessWidget {
  final List<Transaction> tr;
  final List<Wallet> wl;
  const TransactionExpense({
    super.key,
    required this.tr,
    required this.wl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        child: tr.isEmpty
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Thông tin giao dịch: ",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tr.length,
                      itemBuilder: (context, index) {
                        var transaction = tr[index];
                        var wallet = wl
                            .where(
                              (element) =>
                                  element.id_wallet == transaction.id_wallet,
                            )
                            .toList()
                            .first;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          height: 60,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Image.asset(
                                  wallet.icon,
                                ),
                              ),
                              Flexible(
                                flex: 8,
                                child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      width: 1,
                                    ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          transaction.dateTime,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "-${formatMoney(transaction.money.toDouble()) }đ",
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
