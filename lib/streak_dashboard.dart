import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'streak_provider.dart';
import 'streak_badge.dart';
import 'tugas_siswa.dart';

class StreakDashboard extends StatelessWidget {
  const StreakDashboard({super.key});

  void _showStreakPopup(BuildContext context, int currentStreak) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🔥 LUAR BIASA', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_fire_department_rounded, size: 82, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              'Kamu berhasil mempertahankan Streak kamu selama $currentStreak hari!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Lanjutkan'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StreakProvider>();
    final  daftarTugasSiswa = TugasSiswaState().masterDaftarTugas;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas & Streak'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(child: Streakbadge()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CARD PENCAPAIAN STREAK
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.local_fire_department, size: 48, color: Colors.orange),
                    const SizedBox(height: 8),
                    Text(
                      'Pencapaian Streak Kamu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Streak Saat Ini: ${provider.streak.currentStreak} Hari\nRekor Tertinggi: ${provider.streak.highestStreak} Hari',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // DAFTAR TUGAS SISWA (SPREAD OPERATOR ...)
            const Text(
              "Daftar Tugas Aktif:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  ...daftarTugasSiswa.map((tugas) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          tugas.isSelesai ? Icons.check_circle : Icons.pending,
                          color: tugas.isSelesai ? Colors.green : Colors.orange,
                        ),
                        title: Text(
                          tugas.judul,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text("Mapel: ${tugas.kategori}"),
                        trailing: Text(
                          tugas.isSelesai ? "Selesai" : "Belum",
                          style: TextStyle(
                            color: tugas.isSelesai ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // TOMBOL SIMULASI AKSI STREAK
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text('Kumpul Tepat Waktu (+1 Streak)', style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                provider.submitTask(
                  submissionTime: DateTime.now(),
                  deadline: DateTime.now().add(const Duration(hours: 2)),
                );
                _showStreakPopup(context, provider.streak.currentStreak);
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.gpp_bad, color: Colors.white),
              label: const Text('Kumpul Terlambat (Reset ke 0)', style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                provider.submitTask(
                  submissionTime: DateTime.now(),
                  deadline: DateTime.now().subtract(const Duration(hours: 2)),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Yah, streak kamu kembali ke 0'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
