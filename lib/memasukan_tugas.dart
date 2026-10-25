import 'package:flutter/material.dart';

class MemasukanTugas extends StatefulWidget {
  const MemasukanTugas({super.key});

  @override
  State<MemasukanTugas> createState() => _MemasukanTugasState();
}

class _MemasukanTugasState extends State<MemasukanTugas> {
  final TextEditingController _namaTugasController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  final List<Map<String, String>> daftarTugas = [];

  void _tambahTugas() {
    if (_namaTugasController.text.isNotEmpty &&
        _deadlineController.text.isNotEmpty) {
      setState(() {
        daftarTugas.add({
          "nama": _namaTugasController.text,
          "deadline": _deadlineController.text,
        });
      });
      _namaTugasController.clear();
      _deadlineController.clear();
    }
  }

  @override
  void dispose() {
    _namaTugasController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    Widget formInput = Container(
      color: Colors.purple.shade50,
      padding: EdgeInsets.all(isMobile ? 14.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Memasukan Tugas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _namaTugasController,
            decoration: const InputDecoration(
              labelText: "Nama Tugas",
              hintText: "Contoh: PR Matematika Bab 3",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.assignment),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _deadlineController,
            decoration: const InputDecoration(
              labelText: "Deadline",
              hintText: "Contoh: Senin, 13 Oktober 2026",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _tambahTugas,
              icon: const Icon(Icons.add),
              label: const Text("Simpan Tugas"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );

    Widget listTugas = Container(
      color: Colors.white,
      padding: EdgeInsets.all(isMobile ? 14.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar Tugas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          daftarTugas.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      "Belum ada tugas.\nTambahkan lewat form di atas!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: isMobile,
                  physics: isMobile ? const NeverScrollableScrollPhysics() : null,
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
        ],
      ),
    );

    if (isMobile) {
      return SingleChildScrollView(
        child: Column(
          children: [
            formInput,
            listTugas,
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(flex: 3, child: formInput),
        Expanded(flex: 7, child: listTugas),
      ],
    );
  }
}
