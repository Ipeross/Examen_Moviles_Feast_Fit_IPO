import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Screen'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(y: 12, colors: [Colors.blue]),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(y: 8, colors: [Colors.red]),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(y: 15, colors: [Colors.green]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}