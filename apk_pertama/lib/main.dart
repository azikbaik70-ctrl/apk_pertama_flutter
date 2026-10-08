import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:apk_pertama/tugas_siswa.dart';
import 'package:apk_pertama/Catatan_semua_mapel.dart';
import 'package:apk_pertama/materi_yang_dipelajarin.dart' as materi;
import 'package:apk_pertama/memasukan_tugas.dart';
import 'package:apk_pertama/Siswa_Siswi.dart';
import 'package:apk_pertama/guru.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Aplikasi SMPN 1 BOGOR', home: HalamanUtama());
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

  final List<Map<String, dynamic>> dataMenu = [
    {
      "nama": "Guru",
      "subMenu": [
        {"nama": "Bapak Eka", "detail": "Pak Eka Sebagai Guru"},
      ],
    },
    {"nama": "Tugas", "subMenu": []},
    {
      "nama": "Materi yang di pelajarin",
      "subMenu": [
        {"nama": "Ipa"},
      ],
    },
    {
      "nama": "Catatan Semua Mapel",
      "subMenu": [
        {"nama": "mtk"},
      ],
    },
    {
      "nama": "Siswa-siswi",
      "subMenu": [
        {"nama": "aziq"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
            child: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 14),

                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 14),
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

      body: Row(
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
                        : Colors.white.withValues(alpha: 0.4),
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
                        : Colors.white.withValues(alpha: 0.4),
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
                        : Colors.white.withValues(alpha: 0.4),
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
                        : Colors.white.withValues(alpha: 0.4),
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
                        : Colors.white.withValues(alpha: 0.4),
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
                    icon: const Icon(Icons.add_task),
                    color: indexMenu == 5
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.4),
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

          if (indexMenu == 1)
            const Expanded(child: TugasSiswa())
          else if (indexMenu == 2)
            const Expanded(child: materi.materiYangDipelajarin())
          else if (indexMenu == 3)
            const Expanded(child: CatatanSemuaMapel())
          else if (indexMenu == 4)
            const Expanded(child: SiswaSiswi())
          else if (indexMenu == 5)
            const Expanded(child: MemasukanTugas())
          else
            const Expanded(child: gurukelas8c()),
        ],
      ),
    );
  }
}
