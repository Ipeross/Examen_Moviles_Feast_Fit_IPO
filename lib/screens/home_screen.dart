import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
 // Asegúrate de importar SettingsScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: CustomAppBar2(title: 'Inicio'),
      body: Center(child: Text('Hola Mundo')),
    );
  }
}
