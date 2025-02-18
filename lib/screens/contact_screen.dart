import 'package:feast_fit/theme/theme_provider.dart';
import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar3(title: 'Contacto'),
      body: Center(
        child: Text(
          'Contenido de la pantalla de contacto',
          style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}