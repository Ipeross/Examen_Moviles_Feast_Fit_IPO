import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      CustomAppBar2(title: 'Dieta'),
      Expanded(
        child: Center(
          child: Text('FoodScreen'),
        ),
      ),
    ]);
  }
}
