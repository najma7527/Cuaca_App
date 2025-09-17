import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Sidebar extends StatefulWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onProfileSelected;
  final VoidCallback onSettingsSelected;
  final VoidCallback onHistorySelected;
  final VoidCallback onFavoritesSelected;
  final VoidCallback onAboutSelected;
  final VoidCallback onHelpSelected;

  const Sidebar({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onProfileSelected,
    required this.onSettingsSelected,
    required this.onHistorySelected,
    required this.onFavoritesSelected,
    required this.onAboutSelected,
    required this.onHelpSelected,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Galeri'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImageFromGallery();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Kamera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImageFromCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil foto profil dari argument jika ada
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null && args['profileImage'] != null) {
      _profileImage = args['profileImage'];
    }
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Center(child: Text(widget.userName)),
            accountEmail: Center(child: Text(widget.userEmail)),
            currentAccountPicture: GestureDetector(
              onTap: _showImagePickerDialog,
              child: _profileImage != null
                  ? CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.blue[100],
                      backgroundImage: FileImage(_profileImage!),
                    )
                  : CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 40),
                    ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profil'),
            onTap: widget.onProfileSelected,
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.blue),
            title: const Text('Pengaturan'),
            onTap: widget.onSettingsSelected,
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.blue),
            title: const Text('Riwayat Pencarian'),
            onTap: widget.onHistorySelected,
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.blue),
            title: const Text('Kota Favorit'),
            onTap: widget.onFavoritesSelected,
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('Tentang Aplikasi'),
            onTap: widget.onAboutSelected,
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text('Bantuan'),
            onTap: widget.onHelpSelected,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
