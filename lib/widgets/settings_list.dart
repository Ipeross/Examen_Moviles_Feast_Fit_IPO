import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;

  const SettingsList({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = const Color.fromARGB(255, 90, 72, 58),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}