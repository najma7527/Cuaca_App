import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tentang Aplikasi Cuaca',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Aplikasi ini dibuat untuk membantu Anda mengetahui informasi cuaca terkini di berbagai kota. Data cuaca diambil dari OpenWeatherMap dan aplikasi terintegrasi dengan Firebase untuk fitur login, register, favorit, dan riwayat pencarian.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text('Versi: 1.0.0', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              const Text('Developer: Najma7527',
                  style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
