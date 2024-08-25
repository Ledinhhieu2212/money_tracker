import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';

class LineChartScreen extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final List<Transaction> transactions;
  LineChartScreen({
    super.key,
    required this.start,
    required this.end,
    required this.transactions,
  });

  Map<DateTime, int> getTotalNewTransaction(
      {required List<Transaction> transaction,
      required DateTime startTime,
      required DateTime endTime}) {
    Map<DateTime, int> totals = {};

    // Vòng lặp qua từng ngày trong khoảng thời gian từ startTime đến endTime
    for (DateTime date = startTime;
        date.isBefore(endTime) || date.isAtSameMomentAs(endTime);
        date = date.add(
      Duration(days: 1),
    ),) {
      // Tìm các giao dịch xảy ra trong ngày hiện tại
      int dailyTotal = transaction.where((tx) {
        DateTime t = formatStringToDate(tx.dateTime);
        return t.year == date.year &&
            t.month == date.month &&
            t.day == date.day;
      }).fold(0, (sum, tx) => sum + tx.money);

      // Lưu tổng tiền vào bản đồ
      totals[date] = dailyTotal;
    }

    return totals;
  } 
  List<FlSpot> FlSpotData(Map<DateTime, int> transactions) {
    List<FlSpot> spots = [];
    transactions.forEach((date, value) {
      double xValue = date.day.toDouble();
      double yValue = value.toDouble();
      spots.add(
        FlSpot(xValue, yValue),
      );
    });
    return spots;
  }

  final List<Color> grandienColors = [
    CupertinoColors.systemRed,
    CupertinoColors.systemOrange,
  ];

  FlLine backgroundGridLine() {
    return const FlLine(
      color: Colors.white10,
      strokeWidth: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    const AxisTitles hideAxisTile =
        AxisTitles(sideTitles: SideTitles(showTitles: false));
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => backgroundGridLine(),
            getDrawingVerticalLine: (value) => backgroundGridLine(),
          ),
          titlesData: const FlTitlesData(
            show: true,
            rightTitles: hideAxisTile,
            topTitles: hideAxisTile,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: CupertinoColors.systemRed,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                    colors: grandienColors
                        .map((color) => color..withOpacity(0.3))
                        .toList()),
              ),
              spots: FlSpotData(
                getTotalNewTransaction(
                  transaction: transactions,
                  startTime: start,
                  endTime: end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
