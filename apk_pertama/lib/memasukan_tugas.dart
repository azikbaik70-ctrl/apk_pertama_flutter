import 'package:flutter/material.dart';

class MemasukanTugas extends StatefulWidget {
  const MemasukanTugas({super.key});

  @override
  State<MemasukanTugas> createState() => _MemasukanTugasState();
}

class _MemasukanTugasState extends State<MemasukanTugas> {
  // Controller untuk mengambil teks dari TextField
  final TextEditingController _namaTugasController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  // List untuk menyimpan tugas yang ditambahkan
  final List<Map<String, String>> daftarTugas = [];

  // Fungsi untuk menambah tugas
  void _tambahTugas() {
    if (_namaTugasController.text.isNotEmpty &&
        _deadlineController.text.isNotEmpty) {
      setState(() {
        daftarTugas.add({
          "nama": _namaTugasController.text,
          "deadline": _deadlineController.text,
        });
      });
      // Kosongkan form setelah disimpan
      _namaTugasController.clear();
      _deadlineController.clear();
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus
    _namaTugasController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // PANEL KIRI: Form input
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.purple.shade50,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Memasukan Tugas",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _namaTugasController,
                  decoration: const InputDecoration(
                    labelText: "Nama Tugas",
                    hintText: "Contoh: PR Matematika Bab 3",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.assignment),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _deadlineController,
                  decoration: const InputDecoration(
                    labelText: "Deadline",
                    hintText: "Contoh: Senin, 13 Oktober 2026",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _tambahTugas,
                    icon: const Icon(Icons.add),
                    label: const Text("Simpan Tugas"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // PANEL KANAN: Daftar tugas
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daftar Tugas",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: daftarTugas.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada tugas.\nTambahkan lewat form di sebelah kiri!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: daftarTugas.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.edit_note,
                                  color: Colors.purple,
                                ),
                                title: Text(daftarTugas[index]["nama"] ?? ""),
                                subtitle: Text(
                                  "Deadline: ${daftarTugas[index]["deadline"] ?? ""}",
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      daftarTugas.removeAt(index);
                                    });
                                  },
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
      ],
    );
  }
}