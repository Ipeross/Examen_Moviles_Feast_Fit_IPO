import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required Map<String, String> userData});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: CustomAppBar(title: 'Perfil'),
      body: Center(child: Text('Hola Mundo')),
    );
  }
}