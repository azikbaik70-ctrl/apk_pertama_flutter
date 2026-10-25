import 'dart:ui';
import 'dart:convert';
import 'package:apk_pertama/routers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:apk_pertama/login.dart';
import 'package:apk_pertama/register.dart';
import 'package:apk_pertama/tugas_siswa.dart';
import 'package:apk_pertama/Catatan_semua_mapel.dart';
import 'package:apk_pertama/materi_yang_dipelajarin.dart';
import 'package:apk_pertama/memasukan_tugas.dart';
import 'package:apk_pertama/Siswa_Siswi.dart';
import 'package:apk_pertama/guru.dart';
import 'package:apk_pertama/routers.dart';

void main() => runApp(const MyApp());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pesan = "Memuat data...";

  // Fungsi untuk mengambil data dari PHP XAMPP
  Future<void> ambilData() async {
    final url = Uri.parse('http://192.168.1'); 
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          pesan = data['pesan'];
        });
      } else {
        setState(() {
          pesan = "Gagal memuat data dari server";
        });
      }
    } catch (e) {
      setState(() {
        pesan = "Error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(pesan)),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Aplikasi SMPN 1 BOGOR',
    initialRoute: AppRouters.login,
      routes: AppRouters.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int indexMenu = 0;
  int indexSubMenu = 0;

  Widget _dapatkanHalaman(int index) {
    switch (index) {
      case 0:
        return const gurukelas8c();
      case 1:
        return const CatatanSemuaMapel();
      case 2:
        return const materiYangDipelajarin();
      case 3:
        return const TugasSiswa();
      case 4:
        return const SiswaSiswi();
      case 5:
        return const MemasukanTugas();
      default:
        return const gurukelas8c();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
            child: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 11),
                  const Text(
                    'SMP Negeri 1 Bogor',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              foregroundColor: Colors.black,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: Colors.grey.withValues(alpha: 0.2),
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: isMobile
          ? _dapatkanHalaman(indexMenu)
          : Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.8),
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.co_present),
                          color: indexMenu == 0
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 0;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                          icon: const Icon(Icons.edit_note),
                          color: indexMenu == 1
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 1;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                          icon: const Icon(Icons.menu_book),
                          color: indexMenu == 2
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 2;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                          icon: const Icon(Icons.assignment),
                          color: indexMenu == 3
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 3;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                          icon: const Icon(Icons.person),
                          color: indexMenu == 4
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 4;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                          icon: const Icon(Icons.playlist_add),
                          color: indexMenu == 5
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              indexMenu = 5;
                              indexSubMenu = 0;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Sisi kanan konten halaman aktif
                Expanded(
                  child: _dapatkanHalaman(indexMenu),
                ),
              ],
            ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              currentIndex: indexMenu,
              onTap: (index) {
                setState(() {
                  indexMenu = index;
                  indexSubMenu = 0;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black.withValues(alpha: 0.9),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withValues(alpha: 0.5),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.co_present), label: 'Guru'),
                BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Catatan'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Materi'),
                BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tugas'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Siswa'),
                BottomNavigationBarItem(icon: Icon(Icons.playlist_add), label: 'Input'),
              ],
            )
          : null,
    );
  }
}
