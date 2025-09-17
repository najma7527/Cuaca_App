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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Mode Gelap'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: onThemeChanged,
              activeColor: Colors.blue,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pushNamed(context, '/tentang');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text('Bantuan & FAQ'),
            onTap: () {
              Navigator.pushNamed(context, '/faq');
            },
          ),
        ],
      ),
    );
  }
}
