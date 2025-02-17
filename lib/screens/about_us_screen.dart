import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar3(title: 'Información'),
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