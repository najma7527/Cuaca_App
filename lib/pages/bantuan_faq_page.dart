import 'package:flutter/material.dart';

class BantuanFaqPage extends StatelessWidget {
  const BantuanFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'q': 'Bagaimana cara mencari cuaca suatu kota?',
        'a': 'Masukkan nama kota pada halaman utama, lalu tekan tombol Submit.'
      },
      {
        'q': 'Bagaimana cara menambah kota favorit?',
        'a': 'Setelah mencari cuaca, tekan ikon hati untuk menambah ke favorit.'
      },
      {
        'q': 'Bagaimana cara mengubah nama profil?',
        'a': 'Masuk ke halaman profil, ubah nama, lalu tekan Simpan.'
      },
      {
        'q': 'Bagaimana cara mengaktifkan mode gelap?',
        'a': 'Masuk ke halaman pengaturan, aktifkan switch Mode Gelap.'
      },
      {
        'q': 'Bagaimana cara mengirim feedback?',
        'a': 'Masuk ke halaman feedback/saran dan isi form yang tersedia.'
      },
    ];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Bantuan / FAQ'),
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
            children: [
              const Text(
                'Bantuan & FAQ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ...faqs.map((faq) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faq['q']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faq['a']!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
