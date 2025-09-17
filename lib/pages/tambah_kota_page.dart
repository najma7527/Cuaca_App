import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKotaPage extends StatefulWidget {
  const TambahKotaPage({super.key});

  @override
  State<TambahKotaPage> createState() => _TambahKotaPageState();
}

class _TambahKotaPageState extends State<TambahKotaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _populasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _cuacaController = TextEditingController();

  Future<void> tambahKotaBaru() async {
    await FirebaseFirestore.instance
        .collection('kota')
        .doc(_namaController.text.trim())
        .set({
      'nama': _namaController.text.trim(),
      'populasi': int.tryParse(_populasiController.text.trim()) ?? 0,
      'deskripsi': _deskripsiController.text.trim(),
      'cuaca': _cuacaController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tambah Kota'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Kota'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama kota wajib diisi'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _populasiController,
                decoration: const InputDecoration(labelText: 'Populasi'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Populasi wajib diisi'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Deskripsi wajib diisi'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cuacaController,
                decoration: const InputDecoration(labelText: 'Cuaca'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Cuaca wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await tambahKotaBaru();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Kota berhasil ditambahkan!')),
                    );
                    _formKey.currentState!.reset();
                    _namaController.clear();
                    _populasiController.clear();
                    _deskripsiController.clear();
                    _cuacaController.clear();
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
