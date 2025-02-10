import 'package:feast_fit/screens/screens.dart';
import 'package:feast_fit/theme/theme_provider.dart';
import 'package:feast_fit/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sobre Nosotros'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              }else if (value == 'home') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (value == 'toggle_theme') {
                themeProvider.toggleTheme();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'toggle_theme',
                  child: ListTile(
                    leading: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
                    title: Text(themeProvider.themeMode == ThemeMode.dark ? 'Modo Claro' : 'Modo Oscuro'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Ajustes'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'home',
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          InfoSection(
            title: 'Sobre Nosotros',
            text: 'Aquí puedes escribir información sobre nosotros. '
                'Este es el apartado donde puedes detallar quiénes son las personas detrás de la empresa, '
                'sus valores, su misión y cualquier otra información relevante.',
          ),
          InfoSection(
            title: 'Sobre la Empresa',
            text: 'Aquí puedes escribir información sobre la empresa. '
                'Este es el apartado donde podríamos detallar la historia de la empresa, '
                'sus productos o servicios, su visión y cualquier otra información relevante.',
          ),
        ],
      ),
    );
  }
}