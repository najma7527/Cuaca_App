import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'pages/splash_screen.dart';
import 'pages/settings_page.dart';
import 'pages/riwayat_pencarian_page.dart';
import 'pages/favorit_kota_page.dart';
import 'pages/tentang_aplikasi_page.dart';
import 'pages/bantuan_faq_page.dart';
import 'pages/detail_kota_page.dart';
import 'pages/tambah_kota_page.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              textTheme:
                  GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
              useMaterial3: true,
            )
          : ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
              useMaterial3: true,
            ),
      home: const SplashScreen(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDarkMode: isDarkMode,
              onThemeChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
        '/riwayat': (context) => RiwayatPencarianPage(userId: ''),
        '/favorit': (context) => FavoritKotaPage(userId: ''),
        '/tentang': (context) => const TentangAplikasiPage(),
        '/faq': (context) => const BantuanFaqPage(),
        '/detailkota': (context) => const DetailKotaPage(kota: ''),
        '/tambahkota': (context) => const TambahKotaPage(),
      },
    );
  }
}
