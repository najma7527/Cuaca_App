import 'package:flutter/material.dart';
import 'dart:io';

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
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    _profileImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profil',
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/edit_profile',
                  arguments: {
                    'userName': nameController.text,
                    'email': widget.email,
                    'profileImage': _profileImage,
                  });
              if (result != null && result is Map) {
                setState(() {
                  nameController.text = result['name'] ?? nameController.text;
                  _profileImage = result['image'] ?? _profileImage;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue[100],
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(Icons.person, size: 60, color: Colors.blue[700])
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width / 2 - 60,
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                        context, '/edit_profile',
                        arguments: {
                          'userName': nameController.text,
                          'email': widget.email,
                          'profileImage': _profileImage,
                        });
                    if (result != null && result is Map) {
                      setState(() {
                        nameController.text =
                            result['name'] ?? nameController.text;
                        _profileImage = result['image'] ?? _profileImage;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.blue, size: 24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Card(
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: Text(nameController.text,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Nama Lengkap'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Colors.blue),
                    title: Text(widget.email,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Email'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const Icon(Icons.settings, color: Colors.blue),
                    title: const Text('Pengaturan'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const Icon(Icons.help, color: Colors.blue),
                    title: const Text('Bantuan'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onTap: () {
                      Navigator.pushNamed(context, '/faq');
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Logout logic here
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[700],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                side: const BorderSide(color: Colors.blue, width: 2),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
