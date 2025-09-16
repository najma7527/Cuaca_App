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
      appBar: AppBar(title: const Text('Bantuan / FAQ')),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index]['q']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index]['a']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
