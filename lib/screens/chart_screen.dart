import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
   
  const ChartScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar2(title: 'Gráfico'),
      body: Center(
         child: Text('ChartScreen'),
      ),
    );
  }
}