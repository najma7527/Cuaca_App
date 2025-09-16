import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Aplikasi Cuaca',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Versi: 1.0.0'),
            SizedBox(height: 10),
            Text('Dikembangkan oleh: najma7527'),
            SizedBox(height: 10),
            Text(
                'Aplikasi ini memberikan informasi cuaca terkini dan fitur-fitur lain seperti riwayat pencarian, favorit kota, profil, dan pengaturan.'),
            SizedBox(height: 20),
            Text('Kontak: email@domain.com'),
          ],
        ),
      ),
    );
  }
}
