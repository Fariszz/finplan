import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinanceChartData extends StatelessWidget {
  const FinanceChartData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
                color: Colors.lightBlueAccent,
                width: 1,
                style: BorderStyle.solid),
          ),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 1000,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 200),
                FlSpot(1, 150),
                FlSpot(2, 450),
                FlSpot(3, 300),
                FlSpot(4, 600),
                FlSpot(5, 500),
                FlSpot(6, 800),
                FlSpot(7, 1000),
              ],
              isCurved: true,
              color: Colors.blue,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            )
          ])),
    );
  }
}
