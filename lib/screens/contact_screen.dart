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
      appBar: const CustomAppBar3(title: '¿Necesitas ayuda?'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estamos aquí para ayudarte. Completa el formulario o utiliza nuestra información de contacto.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            // Formulario de contacto
            const Text(
              'Nombre',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 52, 45),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Ingresa tu nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 71, 52, 45)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Correo electrónico',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 52, 45)
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Ingresa tu correo electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 71, 52, 45)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Mensaje',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 52, 45)
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje aquí',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 71, 52, 45)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}