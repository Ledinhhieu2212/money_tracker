import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';

class LineChartScreen extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final List<Transaction> transactions;
  List<Color> grandienColors;
  Color income_express;
  LineChartScreen({
    super.key,
    required this.start,
    required this.end,
    required this.transactions,
    this.grandienColors = const [
      CupertinoColors.systemRed,
      CupertinoColors.systemOrange,
    ],
    this.income_express = CupertinoColors.systemRed,
  });

  DateTime removeTimeInDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Map<DateTime, int> getTotalNewTransaction(
      {required List<Transaction> transaction,
      required DateTime startTime,
      required DateTime endTime}) {
    Map<DateTime, int> totals = {};
    DateTime s = removeTimeInDate(startTime), e = removeTimeInDate(endTime);
    for (DateTime date = s;
        date.isBefore(e) || date.isAtSameMomentAs(e);
        date = date.add(
      const Duration(days: 1),
    ),) {
      int dailyTotal = transaction.where((tx) {
        DateTime t = formatStringToDate(tx.dateTime);
        return t.year == date.year &&
            t.month == date.month &&
            t.day == date.day;
      }).fold(0, (sum, tx) => sum + tx.money);
      totals[date] = dailyTotal;
    }

    return totals;
  }

  List<String> _generateDateLabels(DateTime start, DateTime end) {
    List<String> labels = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      labels.add(DateFormat('dd').format(current));
      current = current.add(Duration(days: 1));
    }
    return labels;
  }

  List<FlSpot> FlSpotData(
    Map<DateTime, int> transactions,
    double maxY,
  ) {
    List<FlSpot> spots = [];
    transactions.forEach((date, value) {
      double xValue = date.weekday.toDouble() - 1;
      double yValue = value.toDouble() > maxY ? maxY : value.toDouble();
      spots.add(
        FlSpot(xValue, yValue),
      );
    });
    return spots;
  }

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

    const double maxChartValue = 1000000;
    List<String> dateLabels = _generateDateLabels(start, end);
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          minY: 1000,
          maxY: maxChartValue,
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => backgroundGridLine(),
            getDrawingVerticalLine: (value) => backgroundGridLine(),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: hideAxisTile,
            topTitles: hideAxisTile,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < dateLabels.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        dateLabels[index],
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: const Text(''),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: income_express,
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
                maxChartValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
