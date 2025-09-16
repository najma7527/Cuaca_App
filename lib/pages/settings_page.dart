import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListTile(
        title: const Text('Mode Gelap'),
        trailing: Switch(
          value: isDarkMode,
          onChanged: onThemeChanged,
        ),
      ),
    );
  }
}
