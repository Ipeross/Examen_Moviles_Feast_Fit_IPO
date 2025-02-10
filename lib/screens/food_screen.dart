import 'package:feast_fit/widgets/custom_appbar_2_elements.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
   
  const FoodScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar2(title: 'Dieta'),
      body: Center(
         child: Text('FoodScreen'),
      ),
    );
  }
}