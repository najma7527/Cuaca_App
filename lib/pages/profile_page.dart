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
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title:
            const Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue[200],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person,
                            size: 60, color: Colors.white)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
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
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.blue, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: Text(nameController.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                subtitle: const Text('Nama Lengkap'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: Text(widget.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                subtitle: const Text('Email'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text('Pengaturan',
                    style: TextStyle(color: Colors.blue)),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.help, color: Colors.blue),
                title:
                    const Text('Bantuan', style: TextStyle(color: Colors.blue)),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  Navigator.pushNamed(context, '/faq');
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
