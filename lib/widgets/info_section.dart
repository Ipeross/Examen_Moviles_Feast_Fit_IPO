import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String text;

  const InfoSection({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // Color adaptativo para el título
            color: isDarkMode 
              ? const Color.fromARGB(255, 219, 200, 171) 
              : const Color.fromARGB(255, 104, 85, 56), 
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            // Color adaptativo para el texto
            color: isDarkMode ? Colors.white70 : Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}