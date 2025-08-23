import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';// Pastikan path ini sesuai dengan struktur proyekmu
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart'; // Hasil generate dari FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase berhasil terhubung!");
  } catch (e) {
    print("❌ Firebase gagal terhubung: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Langsung ke halaman login
    );
  }
}
