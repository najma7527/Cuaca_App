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
import 'detail_kota_page.dart';
import 'tambah_kota_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
    // If you want to pre-fill the search field with a value
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

  @override
  Widget build(BuildContext context) {
    double suhu = 0;
    if (isFetch && weather.temp != null) {
      suhu = (weather.temp! - 32) * 5 / 9;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cuaca'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profil',
            onPressed: () {
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
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Pengaturan',
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Riwayat Pencarian',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RiwayatPencarianPage(userId: widget.email ?? ''),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorit Kota',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritKotaPage(userId: widget.email ?? ''),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Tentang Aplikasi',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TentangAplikasiPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: 'Bantuan/FAQ',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BantuanFaqPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.feedback),
            tooltip: 'Feedback/Saran',
            onPressed: () {
              Navigator.pushNamed(context, '/feedback');
            },
          ),
        ],
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
                        'Selamat ${greetingMessage()}, ${widget.value}!',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller,
                        onChanged: (text) {
                          setState(() {
                            namaKota = text;
                          });
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Kota harus diisi.'
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Memproses data')),
                            );
                            isFetch = true;
                            weather =
                                await dataService.fetchData(controller.text);
                            // Simpan ke Firestore
                            try {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.email ?? '')
                                  .collection('riwayat_pencarian')
                                  .add({
                                'kota': controller.text,
                                'cuaca': isFetch && weather.temp != null
                                    ? '${suhuToStringAsFixed((weather.temp! - 32) * 5 / 9, 2)} °C'
                                    : '',
                                'waktu': DateTime.now().millisecondsSinceEpoch,
                              });
                            } catch (e) {
                              print('Gagal simpan riwayat: $e');
                            }
                            setState(() {});
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Text('Cari'),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                isFetch && weather.temp != null
                    ? Container(
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
                                'Kota $namaKota',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              weather.icon != null
                                  ? Image.network(
                                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png')
                                  : const Icon(Icons.image_not_supported,
                                      size: 100, color: Colors.white),
                              Text(
                                '${suhuToStringAsFixed(suhu, 2)} °C',
                                style: const TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                weather.description ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Text(
                        'Silakan masukkan nama kota terlebih dahulu!',
                        style: TextStyle(color: Colors.black),
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
