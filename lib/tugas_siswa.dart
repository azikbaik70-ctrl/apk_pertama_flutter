import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:apk_pertama/memasukan_tugas.dart';

class TugasSiswa extends StatefulWidget {
  const TugasSiswa({super.key});

  @override
  State<TugasSiswa> createState() => _TugasSiswaState();
}

class ItemTugas {
  final String judul;
  final String kategori;
  final String deskripsi;
  bool isSelesai;
  final DateTime tanggalDibuat;

  ItemTugas({
    required this.judul,
    required this.kategori,
    required this.deskripsi,
    required this.isSelesai,
    required this.tanggalDibuat,
  });
}

class _TugasSiswaState extends State<TugasSiswa> {
  int indexSubMenu = 0;
  String filterWaktuAktif = 'semua';

  // null = tampil halaman daftar, terisi = tampil halaman detail
  ItemTugas? tugasDipilih;

  final Map<String, Map<String, dynamic>> opsiFilter = {
    'semua': {'label': 'Semua', 'hari': null, 'warna': Colors.purple},
    'sehari': {'label': '1 Hari', 'hari': 1, 'warna': Colors.green},
    'seminggu': {'label': '1 Minggu', 'hari': 7, 'warna': Colors.blue},
    'tiga_minggu': {'label': '3 Minggu', 'hari': 21, 'warna': Colors.orange},
    'dua_bulan': {'label': '2 Bulan', 'hari': 60, 'warna': Colors.teal},
  };

  final List<Map<String, String>> subMenuTugas = [
    {"nama": "IPA", "kode": "IPA"},
    {"nama": "Mtk", "kode": "MTK"},
    {"nama": "PAI", "kode": "PAI"},
    {"nama": "PAK", "kode": "PAK"},
    {"nama": "PJOK", "kode": "PJOK"},
    {"nama": "English", "kode": "ENG"},
    {"nama": "B.indonesia", "kode": "B.INDO"},
    {"nama": "IPS", "kode": "IPS"},
    {"nama": "Seni Budaya", "kode": "SENBUD"},
    {"nama": "B.Sunda", "kode": "B.SUNDA"},
  ];
 
  // Ikon untuk tiap mapel (berdasarkan kode)
  final Map<String, IconData> ikonMapel = {
    
    'IPA': Icons.science,
    'MTK': Icons.calculate,
    'PAI': Icons.menu_book,
    'PAK': Icons.auto_stories,
    'PJOK': Icons.sports_soccer,
    'ENG': Icons.language,
    'B.INDO': Icons.book,
    'IPS': Icons.public,
    'SENBUD': Icons.palette,
    'B.SUNDA': Icons.translate,
  };

  // List: tidak perlu key String, langsung tulis icon-nya saja.
  // Yang paling atas (index 0) = ikon sekolah.
  final List<IconData> ikonAtas = [
    Icons.school_outlined,
  ];

  final List<ItemTugas> masterDaftarTugas = [
    ItemTugas(
      judul: 'PR Konstanta Halaman 32',
      kategori: 'MTK',
      deskripsi: 'Kerjakan soal nomor 1-10 di buku paket halaman 32.',
      isSelesai: true,
      tanggalDibuat: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ItemTugas(
      judul: 'PR Biantara Hal 20',
      kategori: 'B.SUNDA',
      deskripsi: 'Buat teks biantara singkat dan hafalkan.',
      isSelesai: false,
      tanggalDibuat: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ItemTugas(
      judul: 'PR Subjektif & Objektif Hal 30',
      kategori: 'B.INDO',
      deskripsi: 'Kerjakan latihan 2 tentang kalimat subjektif dan objektif.',
      isSelesai: true,
      tanggalDibuat: DateTime.now().subtract(const Duration(days: 10)),
    ),
    ItemTugas(
      judul: 'PR Perbedaan Sel Hewan dan Sel Tumbuhan',
      kategori: 'IPA',
      deskripsi: 'Buat tabel perbedaan sel hewan dan sel tumbuhan.',
      isSelesai: false,
      tanggalDibuat: DateTime.now().subtract(const Duration(days: 12)),
    ),
    ItemTugas(
      judul: 'PR Organel Sel',
      kategori: 'IPA',
      deskripsi: 'Sebutkan fungsi minimal 5 organel sel.',
      isSelesai: false,
      tanggalDibuat: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    ItemTugas(
      judul: 'Laporan Praktikum Mikroskop',
      kategori: 'IPA',
      deskripsi: 'Tulis laporan praktikum pengamatan sel bawang.',
      isSelesai: true,
      tanggalDibuat: DateTime.now().subtract(const Duration(days: 45)),
    ),
  ];

  List<ItemTugas> get dapatkanTugas {
    final kodeSekarang = subMenuTugas[indexSubMenu]["kode"]!;
    final hari = opsiFilter[filterWaktuAktif]!['hari'] as int?;
    final sekarang = DateTime.now();

    final hasil = masterDaftarTugas.where((tugas) {
      final cocokKategori =
          tugas.kategori.toLowerCase() == kodeSekarang.toLowerCase();
      final cocokWaktu =
          hari == null ||
          tugas.tanggalDibuat.isAfter(sekarang.subtract(Duration(days: hari)));
      return cocokKategori && cocokWaktu;
    }).toList();

    hasil.sort((a, b) => b.tanggalDibuat.compareTo(a.tanggalDibuat));
    return hasil;
  }

  String formatTanggal(DateTime d) => "${d.day}-${d.month}-${d.year}";

  // =====================================================
  // HALAMAN 1: DAFTAR CARD (satu halaman penuh)
  // =====================================================
  Widget halamanDaftar() {
    final listTersaring = dapatkanTugas;
    final namaMenu = subMenuTugas[indexSubMenu]["nama"]!;
    final jumlahSelesai = listTersaring.where((t) => t.isSelesai).length;

    return Container(
      key: const ValueKey('daftar'),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FA),
        border: const Border(
  left: BorderSide(color: Color(0xFFD9D4E3), width: 1.5),
  right: BorderSide(color: Color(0xFFD9D4E3), width: 1.5),
  top: BorderSide(color: Color(0xFFD9D4E3), width: 1.5),
),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon sekolah di paling atas, diambil dari List index 0 (tanpa key String)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Icon(
              ikonAtas[0],
              size: 30,
              color: const Color(0xFF6A1B9A),
            ),
          ),
          // Filter waktu
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text(
                  "Periode Waktu: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                ...opsiFilter.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(e.value['label'] as String),
                      selected: filterWaktuAktif == e.key,
                      selectedColor: (e.value['warna'] as Color).withValues(
                        alpha: 0.3,
                      ),
                      onSelected: (_) =>
                          setState(() => filterWaktuAktif = e.key),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Garis lurus pemisah di bawah "Periode Waktu"
          const Divider(thickness: 1, color: Color(0xFFE0DDE8)),
          const SizedBox(height: 12),
         

          // Header gradasi + progress bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(
                    'assets/lottie/books.json',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaMenu,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$jumlahSelesai dari ${listTersaring.length} tugas selesai",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: listTersaring.isEmpty
                              ? 0
                              : jumlahSelesai / listTersaring.length,
                          minHeight: 7,
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Daftar card, memenuhi sisa halaman
          Expanded(
            child: listTersaring.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 70,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Tidak ada riwayat tugas pada waktu ini.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: listTersaring.length,
                    itemBuilder: (context, idx) {
                      final tugas = listTersaring[idx];
                      final warna = tugas.isSelesai
                          ? Colors.green
                          : Colors.orange;

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shadowColor: warna.withValues(alpha: 0.25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          // KLIK CARD -> pindah ke halaman detail
                          onTap: () => setState(() => tugasDipilih = tugas),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                // Garis aksen warna di kiri card
                                Container(width: 6, color: warna),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        // Ikon status: klik = ubah status cepat
                                        Tooltip(
                                          message: "Klik untuk ubah status",
                                          child: InkWell(
                                            customBorder: const CircleBorder(),
                                            onTap: () => setState(
                                              () => tugas.isSelesai =
                                                  !tugas.isSelesai,
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: warna.withValues(
                                                  alpha: 0.12,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                tugas.isSelesai
                                                    ? Icons.check_circle
                                                    : Icons.pending_actions,
                                                color: warna,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        // Judul + tanggal
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                tugas.judul,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_today,
                                                    size: 13,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    formatTanggal(
                                                      tugas.tanggalDibuat,
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Badge status
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warna.withValues(
                                              alpha: 0.12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color: warna.withValues(
                                                alpha: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            tugas.isSelesai
                                                ? "Selesai"
                                                : "Belum",
                                            style: TextStyle(
                                              color: warna,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // HALAMAN 2: DETAIL (muncul geser dari kanan)
  // =====================================================
  Widget halamanDetail(ItemTugas tugas) {
    final warna = tugas.isSelesai ? Colors.green : Colors.orange;
    final selisihHari = DateTime.now().difference(tugas.tanggalDibuat).inDays;

    return Container(
      key: const ValueKey('detail'),
      color: const Color(0xFFF5F3FA),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tombol kembali
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.purple,
                  onPressed: () => setState(() => tugasDipilih = null),
                ),
                const Text(
                  "Kembali",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              tugas.judul,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subMenuTugas[indexSubMenu]["nama"]!,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Kotak status besar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: warna.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: warna),
              ),
              child: Row(
                children: [
                  Icon(
                    tugas.isSelesai
                        ? Icons.check_circle
                        : Icons.pending_actions,
                    color: warna,
                    size: 48,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tugas.isSelesai ? "Sudah Selesai" : "Belum Selesai",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warna,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tugas.isSelesai
                              ? "Tugas ini sudah kamu kerjakan."
                              : "Tugas ini belum dikerjakan.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info tanggal dalam bentuk chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.purple,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Dibuat: ${formatTanggal(tugas.tanggalDibuat)} "
                    "($selisihHari hari lalu)",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Kartu deskripsi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 18,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Deskripsi Tugas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tugas.deskripsi,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Tombol tandai selesai
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tugas.isSelesai
                      ? Colors.orange
                      : Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: Icon(tugas.isSelesai ? Icons.undo : Icons.check),
                label: Text(
                  tugas.isSelesai
                      ? "Tandai Belum Selesai"
                      : "Tandai Sudah Selesai",
                ),
                onPressed: () =>
                    setState(() => tugas.isSelesai = !tugas.isSelesai),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Column(
        children: [
          // Filter Mapel (Horizontal Chips) untuk HP Android
          Container(
            color: const Color(0xFF2E0854),
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: subMenuTugas.length,
              itemBuilder: (context, index) {
                final dipilih = indexSubMenu == index;
                final kode = subMenuTugas[index]["kode"]!;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    avatar: Icon(
                      ikonMapel[kode] ?? Icons.book_rounded,
                      color: dipilih ? Colors.purple : Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      subMenuTugas[index]["nama"]!,
                      style: TextStyle(
                        color: dipilih ? Colors.purple : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: dipilih,
                    selectedColor: Colors.white,
                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          indexSubMenu = index;
                          tugasDipilih = null;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          // Area Konten Tugas Full-Width
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: tugasDipilih == null
                  ? halamanDaftar()
                  : halamanDetail(tugasDipilih!),
            ),
          ),
        ],
      );
    }

    // Tampilan Browser / Desktop (Sama Seperti Bawaan: 2 Kolom Sampingan)
    return Row(
      children: [
        // ===== MENU KIRI =====
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF2E0854),
            ),
            child: Column(
              children: [
                // Header sidebar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.assignment_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Tugas Sekolah",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white24, height: 1),
                const SizedBox(height: 10),
                // Daftar mapel
                Expanded(
                  child: ListView.builder(
                    itemCount: subMenuTugas.length,
                    itemBuilder: (context, index) {
                      final dipilih = indexSubMenu == index;
                      final kode = subMenuTugas[index]["kode"]!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        child: Material(
                          color: dipilih
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            dense: true,
                            leading: Icon(
                              ikonMapel[kode] ?? Icons.book_rounded,
                              color: dipilih ? Colors.white : Colors.white70,
                              size: 22,
                            ),
                            title: Text(
                              subMenuTugas[index]["nama"]!,
                              style: TextStyle(
                                color: dipilih ? Colors.white : Colors.white70,
                                fontWeight: dipilih
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: dipilih
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 8,
                                  )
                                : null,
                            splashColor: Colors.white.withValues(alpha: 0.2),
                            hoverColor: Colors.white.withValues(alpha: 0.08),
                            onTap: () => setState(() {
                              indexSubMenu = index;
                              tugasDipilih = null;
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // ===== AREA KANAN (daftar <-> detail) =====
        Expanded(
          flex: 8,
          child: ClipRect(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              layoutBuilder: (current, previous) => Stack(
                fit: StackFit.expand,
                children: [...previous, if (current != null) current],
              ),
              transitionBuilder: (child, animation) {
                final isDetail = child.key == const ValueKey('detail');
                if (isDetail) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  );
                }
                return FadeTransition(opacity: animation, child: child);
              },
              child: tugasDipilih == null
                  ? halamanDaftar()
                  : halamanDetail(tugasDipilih!),
            ),
          ),
        ),
      ],
    );
  }
}
