import 'package:feast_fit/screens/screens.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(
                    userData: {
                      'name': 'Juan Pérez',
                      'email': 'juan.perez@example.com',
                      'phone': '123456789',
                      'gender': 'Masculino',
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Acerca de Nosotros'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}