import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TugasSiswa extends StatefulWidget {
  const TugasSiswa({super.key});

  @override
  State<TugasSiswa> createState() => _TugasSiswaState(); 
}
class ItemTugas {
    final String judul;
    final String kategori;
    final bool isSelesai;
    final DateTime tanggalDibuat;

    ItemTugas({
      required this.judul,
      required this.kategori,
      required this.isSelesai,
      required this.tanggalDibuat,
    });
}
  

class _TugasSiswaState extends State<TugasSiswa> {
  int indexSubMenu = 0;
  String filterWaktuAktif = 'semua'; // Pilihan: 'semua', 'seminggu', 'dua_bulan'


  final List<Map<String, dynamic>> subMenuTugas = [
    {"nama": "IPA"},
    {"nama": "Mtk", "detail": "tugas"},
    {"nama": "PAI", "detail": "tugas"},
    {"nama": "PAK", "detail": "tugas"},
    {"nama": "PJOK", "detail": "tugas"},
    {"nama": "English", "detail": "tugas"},
    {"nama": "B.indonesia", "detail": "tugas"},
    {"nama": "IPS", "detail": "tugas"},
    {"nama": "Seni Budaya", "detail": "tugas"},
    {"nama": "B.Sunda", "detail": "tugas"},
  ];
  final List<ItemTugas> masterDaftarTugas = [
    ItemTugas(judul: 'PR Konstanta Halaman 32', kategori: 'MTK', isSelesai: true, tanggalDibuat: DateTime.now().subtract(const Duration(days: 3))),
    ItemTugas(judul: 'PR  Biantara Hal 20', kategori: 'B.Sunda', isSelesai: false, tanggalDibuat: DateTime.now().subtract(const Duration(days: 5))),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.purple,
            child: ListView.builder(
              itemCount: subMenuTugas.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(
                      subMenuTugas[index]["nama"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                    tileColor: indexSubMenu == index
                        ? Colors.purpleAccent
                        : Colors.transparent,
                    splashColor: Colors.white.withValues(alpha: 0.3),
                    hoverColor: Colors.white.withValues(alpha: 0.1),
                    selected: indexSubMenu == index,
                    onTap: () {
                      setState(() {
                        indexSubMenu = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset(
                  'assets/lottie/books.json',
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Detail Tugas:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subMenuTugas[indexSubMenu]["nama"] ?? "",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subMenuTugas[indexSubMenu]["detail"] ??
                      "Tidak ada deksripsi.",
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
