import 'package:flutter/material.dart';
import 'dart:async';
import '../login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/newlogo.png', width: 150),
            const SizedBox(height: 40),
            Text(
              'Aplikasi Cuaca',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700]),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.blue),
            const SizedBox(height: 10),
            Text('Memuat...', style: TextStyle(color: Colors.blue[700])),
          ],
        ),
      ),
    );
  }
}
