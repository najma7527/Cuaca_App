import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cuaca_app/pages/detail_weather.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? nameValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Selamat Datang di Aplikasi Cuaca',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/newlogo.png'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Nama',
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onChanged: (text) => nameValue = text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nama harus diisi.'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email harus diisi.';
                    } else if (!value.contains('@')) {
                      return 'Email tidak valid.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  validator: (value) => value == null || value.length < 6
                      ? 'Password minimal 6 karakter.'
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Berhasil')),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailWheater(
                              value: nameValue,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Gagal Login: ${e.toString()}')),
                        );
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text("Belum punya akun? Daftar di sini"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
