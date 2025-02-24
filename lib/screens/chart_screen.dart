import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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

  List<String> dates = [];

  final TextEditingController _controllerValue = TextEditingController();

  void toggleChartType() {
    setState(() {
      isBarChart = !isBarChart;
    });
  }

  void addData() {
    final double value = double.tryParse(_controllerValue.text) ?? 0;

    if (value != 0) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

        chartData.add(FlSpot(chartData.length.toDouble(), value));
        dates.add(formattedDate);
      });
      _controllerValue.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar2(
          title: 'Gráficos',
        ),
        Expanded(
          child: Padding(
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
                const SizedBox(height: 30),

                SizedBox(
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
                                      gradientColors[index % gradientColors.length]
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
                                  return dates[value.toInt()];
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
                                  return dates[value.toInt()];
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
        ),
      ],
    );
  }
}
