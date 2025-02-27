import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool isBarChart = true;

  final List<Color> gradientColors = [
    const Color(0xffc08f66),
    const Color(0xffa2674b),
    const Color(0xff8b4f32),
  ];

  List<FlSpot> chartData = [];

  final TextEditingController _controllerValue = TextEditingController();

  void toggleChartType() {
    setState(() {
      isBarChart = !isBarChart;
    });
  }

  void addData() {
    final double value = double.tryParse(_controllerValue.text) ?? 0;

    if (value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El valor debe ser mayor que 0")),
      );
      return;
    }

    setState(() {
      chartData.add(FlSpot(chartData.length.toDouble(), value));
    });

    _controllerValue.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar2(
            title: 'Gráficos',
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Visualiza tus datos en diferentes formatos.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _controllerValue,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addData,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: gradientColors.first,
                  ),
                  child: const Text('Agregar Datos'),
                ),
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: isBarChart
                        ? BarChart(
                            BarChartData(
                              barGroups: chartData.asMap().entries.map((entry) {
                                int index = entry.key;
                                FlSpot spot = entry.value;
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      y: spot.y,
                                      colors: [
                                        gradientColors[
                                            index % gradientColors.length]
                                      ],
                                      width: 20,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                  showingTooltipIndicators: [0],
                                );
                              }).toList(),
                              titlesData: FlTitlesData(
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value) {
                                    int index = value.toInt();
                                    return index < chartData.length
                                        ? '${index + 1}º'
                                        : '';
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: false,
                                ),
                                topTitles: SideTitles(
                                  showTitles: false,
                                ),
                                rightTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              barTouchData: BarTouchData(enabled: false),
                            ),
                          )
                        : LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: chartData,
                                  isCurved: true,
                                  colors: gradientColors,
                                  barWidth: 4,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    colors: gradientColors
                                        .map((color) => color.withOpacity(0.3))
                                        .toList(),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value) {
                                    int index = value.toInt();
                                    if (index < chartData.length) {
                                      return '${index + 1}º';
                                    }
                                    return '';
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: false,
                                ),
                                topTitles: SideTitles(
                                  showTitles: false,
                                ),
                                rightTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineTouchData: LineTouchData(enabled: false),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: toggleChartType,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: gradientColors.first,
                  ),
                  child: Text(isBarChart
                      ? 'Cambiar a Gráfico de Líneas'
                      : 'Cambiar a Gráfico de Barras'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
