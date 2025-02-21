import 'package:feast_fit/screens/screens.dart';
import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BackgroundContainer(
          child: TabBarView(
            children: [
              HomeScreen(),
              FoodScreen(),
              ChartScreen(),
            ],
          ),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Inicio'),
            Tab(icon: Icon(Icons.fastfood), text: 'Dieta'),
            Tab(icon: Icon(Icons.bar_chart), text: 'Gráfico'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
    );
  }
}

