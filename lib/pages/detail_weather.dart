import 'package:cuaca_app/model/weather.dart';
import 'package:cuaca_app/service/data_Service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'riwayat_pencarian_page.dart';
import 'favorit_kota_page.dart';
import 'tentang_aplikasi_page.dart';
import 'bantuan_faq_page.dart';
import 'tambah_kota_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sidebar.dart';

class DetailWheater extends StatefulWidget {
  final String? value;
  final String? email;
  final String? password;

  DetailWheater({super.key, this.value, this.email, this.password});

  @override
  State<DetailWheater> createState() => _DetailWheaterState();
}

class _DetailWheaterState extends State<DetailWheater> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather weather = Weather();
  final formKey = GlobalKey<FormState>();

  String? namaKota = '';
  bool isFetch = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      controller.text = widget.value!;
      namaKota = widget.value;
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Pagi';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Siang';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  String suhuToStringAsFixed(double suhu, int afterDecimal) {
    final parts = suhu.toString().split('.');
    String decimal = parts.length > 1 ? parts[1] : '0';
    decimal = decimal.substring(
        0, decimal.length < afterDecimal ? decimal.length : afterDecimal);
    return '${parts[0]}.$decimal';
  }

  Future<void> _searchWeather() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        isFetch = false;
        errorMessage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Memproses data...')),
      );

      try {
        Weather fetchedWeather = await dataService.fetchData(controller.text);

        setState(() {
          weather = fetchedWeather;
          namaKota = controller.text;
          isFetch = true;
          isLoading = false;
        });

        // Simpan ke Firestore riwayat pencarian
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email ?? '')
              .collection('riwayat_pencarian')
              .add({
            'kota': controller.text,
            'cuaca': weather.temp != null
                ? '${suhuToStringAsFixed((weather.temp! - 32) * 5 / 9, 2)} °C'
                : '',
            'waktu': DateTime.now().millisecondsSinceEpoch,
          });
        } catch (e) {
          print('Gagal simpan riwayat: $e');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          isFetch = false;
          errorMessage = e.toString();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double suhu = 0;
    if (isFetch && weather.temp != null) {
      suhu = (weather.temp! - 32) * 5 / 9;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Cuaca'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: Sidebar(
        userName: widget.email?.split('@').first ?? 'User',
        userEmail: widget.email ?? '',
        onProfileSelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                name: widget.value ?? '',
                email: widget.email ?? '',
                password: widget.password ?? '',
              ),
            ),
          );
        },
        onSettingsSelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SettingsPage(isDarkMode: false, onThemeChanged: (v) {}),
            ),
          );
        },
        onHistorySelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RiwayatPencarianPage(userId: widget.email ?? ''),
            ),
          );
        },
        onFavoritesSelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritKotaPage(userId: widget.email ?? ''),
            ),
          );
        },
        onAboutSelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TentangAplikasiPage(),
            ),
          );
        },
        onHelpSelected: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BantuanFaqPage(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Selamat ${greetingMessage()}, ${widget.value ?? "User"}!',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              onChanged: (text) {
                                setState(() {
                                  namaKota = text;
                                });
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Kota harus diisi.'
                                      : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Masukkan nama kota',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  )),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite_border,
                                color: Colors.red),
                            tooltip: 'Favoritkan kota',
                            onPressed: () async {
                              if (controller.text.isNotEmpty) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.email ?? '')
                                      .collection('favorit_kota')
                                      .add({
                                    'kota': controller.text,
                                    'waktu':
                                        DateTime.now().millisecondsSinceEpoch,
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Kamu memfavoritkan kota ${controller.text}')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Gagal memfavoritkan kota: $e')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Masukkan nama kota terlebih dahulu!')),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.blueAccent.shade200),
                            shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.blueAccent.shade200)))),
                        onPressed: isLoading ? null : _searchWeather,
                        child: isLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Text('Cari'),
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Loading indicator
                if (isLoading) const CircularProgressIndicator(),

                // Error message
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                // Weather data display
                if (isFetch && weather.temp != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      boxShadow: const [
                        BoxShadow(color: Colors.blue, spreadRadius: 3),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Text(
                            'Kota ${weather.name ?? namaKota}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          weather.icon != null
                              ? Image.network(
                                  'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                  width: 100,
                                  height: 100,
                                )
                              : const Icon(Icons.image_not_supported,
                                  size: 100, color: Colors.white),
                          const SizedBox(height: 10),
                          Text(
                            '${suhuToStringAsFixed(suhu, 2)} °C',
                            style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            weather.description ?? 'Tidak ada deskripsi',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (!isLoading && !isFetch)
                  const Text(
                    'Silakan masukkan nama kota terlebih dahulu!',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
