import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailKotaPage extends StatelessWidget {
  final String kota;
  const DetailKotaPage({super.key, required this.kota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Kota: $kota')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('kota').doc(kota).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Data kota tidak ditemukan.'));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Kota: ${data['nama'] ?? kota}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Populasi: ${data['populasi'] ?? '-'}'),
                const SizedBox(height: 10),
                Text('Deskripsi: ${data['deskripsi'] ?? '-'}'),
                const SizedBox(height: 10),
                Text('Cuaca Terkini: ${data['cuaca'] ?? '-'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
