import 'package:feast_fit/screens/screens.dart';
import 'package:feast_fit/theme/theme_provider.dart';
import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



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
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark 
                ? Icons.light_mode 
                : Icons.dark_mode
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingsList(
            icon: Icons.person,
            title: 'Perfil',
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
          SettingsList(
            icon: Icons.info,
            title: 'Acerca de Nosotros',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
          // Nuevo campo: Contacto
          SettingsList(
            icon: Icons.contact_mail, // Icono para contacto
            title: 'Contacto',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactScreen(), // Navega a ContactScreen
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}