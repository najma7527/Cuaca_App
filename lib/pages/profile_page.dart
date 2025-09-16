import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: widget.email,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: widget.password,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan nama
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nama berhasil diubah')),
                );
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
