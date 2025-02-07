import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 124, 113, 99),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Sobre Nosotros',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 104, 85, 56),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Aquí puedes escribir información sobre nosotros. '
            'Este es el apartado donde puedes detallar quiénes son las personas detrás de la empresa, '
            'sus valores, su misión y cualquier otra información relevante.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Sobre la Empresa',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 104, 85, 56),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Aquí puedes escribir información sobre la empresa. '
            'Este es el apartado donde podríamos detallar la historia de la empresa, '
            'sus productos o servicios, su visión y cualquier otra información relevante.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}