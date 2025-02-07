import 'package:feast_fit/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart'; // Asegúrate de que la ruta sea correcta
import 'about_us_screen.dart'; // Asegúrate de que la ruta sea correcta

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blueAccent),
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