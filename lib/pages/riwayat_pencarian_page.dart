import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RiwayatPencarianPage extends StatelessWidget {
  final String userId;
  const RiwayatPencarianPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pencarian Cuaca')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('riwayat_pencarian')
            .orderBy('waktu', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada riwayat pencarian.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['kota'] ?? '-'),
                subtitle: Text(data['waktu'] != null
                    ? DateTime.fromMillisecondsSinceEpoch(data['waktu'])
                        .toString()
                    : ''),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
