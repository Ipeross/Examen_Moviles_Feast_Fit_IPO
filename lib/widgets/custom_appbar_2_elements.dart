import 'package:feast_fit/screens/screens.dart';
import 'package:feast_fit/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar2({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'settings') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            } else if (value == 'home') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (value == 'toggle_theme') {
              themeProvider.toggleTheme();
            }
            else if (value == 'login_out') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'toggle_theme',
                child: ListTile(
                  leading: Icon(themeProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  title: Text(themeProvider.themeMode == ThemeMode.dark
                      ? 'Modo Claro'
                      : 'Modo Oscuro'),
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
                value: 'login_out',
                child: ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Logout'),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
