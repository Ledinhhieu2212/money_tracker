import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:money_tracker/view/pages/wallet/widgets/select_wallet.dart';
import 'package:money_tracker/view/widgets/charts/bar_chart.dart' as custom;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/widgets/list_wallet.dart';

class ExpenseIncome extends StatefulWidget {
  const ExpenseIncome({super.key});

  @override
  State<ExpenseIncome> createState() => _ExpenseIncomeState();
}

class _ExpenseIncomeState extends State<ExpenseIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("expense_income".tr),
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
  List<DataModel> items = [];
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
    await _connectWallet(userId);
  }

  _connectWallet(int userId) async {
    wallertService = WalletService(await getDatabaseWallet());
    var data = await wallertService.searchWallets(userId);
    var d = data.where((element) => element.status == 1).toList();
    await _connectTransaction(userId, d);
    setState(() {
      wallets = d;
    });
  }

  _connectTransaction(int userId, List<Wallet> wl) async {
    service = TransactionService(await getDatabase());
    var data = await service.searchOfUser(userId: userId);
    var trs = data.where((element) {
      DateTime date = formatStringToDate(element.dateTime);
      return date.compareTo(_startDate!) >= 0 && date.compareTo(_endDate!) <= 0;
    }).toList();
    List<Transaction> transactionss = [];
    for (var tr in trs) {
      for (var w in wl) {
        if (tr.id_wallet == w.id_wallet) {
          transactionss.add(tr);
        }
      }
    }

    setState(() {
      transactions = transactionss;
      items = getTotalNewTransaction(
          transactions: transactions,
          startTime: _startDate!,
          endTime: _endDate!);
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

  List<DataModel> getTotalNewTransaction(
      {required List<Transaction> transactions,
      required DateTime startTime,
      required DateTime endTime}) {
    List<DataModel> items = [];
    bool isSameDate(String txDateTime, DateTime date) {
      DateTime t = formatStringToDate(txDateTime);
      return t.year == date.year && t.month == date.month && t.day == date.day;
    }

    DateTime s = removeTimeDate(startTime), e = removeTimeDate(endTime);

    for (DateTime date = s;
        date.isBefore(e) || date.isAtSameMomentAs(e);
        date = date.add(
      const Duration(days: 1),
    ),) {
      double incomeTotal = 0.0, expenseTotal = 0.0;
      var tr = transactions.where((tx) => isSameDate(tx.dateTime, date));
      for (var t in tr) {
        if (t.transaction_type == 1) incomeTotal += t.money;
        if (t.transaction_type == 0) expenseTotal += t.money;
      }
      items.add(
        DataModel(
          key: date.day,
          datetime: date,
          income: incomeTotal,
          expense: expenseTotal,
        ),
      );
    }

    return items;
  }

  List<BarChartGroupData> getBarChart(List<DataModel> items) {
    List<BarChartGroupData> rawBarGroups = [];
    // items.insert(,)
    return rawBarGroups;
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups(
      List<DataModel> items, double maxChartValue) {
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.income == 0
                ? 0.1
                : ((data.income > maxChartValue) ? maxChartValue : data.income),
            color: Colors.green,
            width: 15,
          ),
          BarChartRodData(
            toY: data.expense == 0
                ? 0.1
                : ((data.expense > maxChartValue)
                    ? maxChartValue
                    : data.expense),
            color: Colors.red,
            width: 15,
          ),
        ],
        barsSpace: 5,
      );
    }).toList();
  }

  FlLine backgroundGridLine() {
    return const FlLine(
      color: Colors.white10,
      strokeWidth: 1,
    );
  }

  AxisTitles hideAxisTile =
      const AxisTitles(sideTitles: SideTitles(showTitles: false));
  @override
  Widget build(BuildContext context) {
    const double maxChartValue = 1000000;
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
                color: Colors.blue,
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
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildLegendItem(Colors.green, "Thu nhập"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildLegendItem(Colors.red, "Chi tiêu"),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                      minY: 1000,
                      maxY: maxChartValue,
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) =>
                            backgroundGridLine(),
                        getDrawingVerticalLine: (value) => backgroundGridLine(),
                      ),
                      alignment: BarChartAlignment.spaceEvenly,
                      barGroups: _buildBarGroups(items, maxChartValue),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: hideAxisTile,
                        topTitles: hideAxisTile,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              return Text(
                                items[index].datetime?.day.toString() ?? '',
                                style: TextStyle(color: Colors.black),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Thông tin giao dịch: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            getToPageToBack(page: ()=>const SelectWallet());
                          },
                          icon: Icon(Icons.settings),
                        ),
                      ],
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
                        String text = tr[index].transaction_type == 1
                            ? '+${formatMoney(tr[index].money.toDouble())}đ'
                            : '-${formatMoney(tr[index].money.toDouble())}đ';
                        Color color = tr[index].transaction_type == 1
                            ? Colors.green
                            : Colors.red;
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
                                          text,
                                          style: TextStyle(
                                            color: color,
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

class DataModel {
  int? key;
  DateTime? datetime;
  double income;
  double expense;
  DataModel({
    required this.key,
    required this.datetime,
    required this.income,
    required this.expense,
  });

  Map<String, Object?> toMap() {
    return {
      'key': key,
      'datetime': datetime,
      'income': income,
      'expense': expense,
    };
  }
}
