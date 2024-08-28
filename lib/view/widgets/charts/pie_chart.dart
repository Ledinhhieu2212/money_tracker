import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartPage extends StatelessWidget {
  Map<String, double> dataMap = {
    "Flutter": 4,
    "Firebase": 1,
    "Dart": 2,
    "Figma": 3,
    "YouTube": 1.4,
  };
  PieChartPage({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PieChart(PieChartData()),
      ),
    );
  }
}
