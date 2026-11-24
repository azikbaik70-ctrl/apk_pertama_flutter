import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apk_pertama/tugas_siswa.dart';
import 'package:apk_pertama/Upload_tugas-siswa-siswi.dart';
class HalamanTugasSiswa extends StatefulWidget{
  const HalamanTugasSiswa({super.key});

  @override
  State<HalamanTugasSiswa> createState() => HalamanTugasSiswaState();
}
// Syntax final FotoTugas = ... itu mengambil dari file Upload_tugas-siswa-siswi.dart
class HalamanTugasSiswaState extends State<HalamanTugasSiswa> {
  final  halamanTugas = TugasSiswaState().masterDaftarTugas;
  final _FotoTugas =  UploadTugasState().ambilFotoTugas;

  File? _fotoTugasSiswa;
  bool _sedangMengecek = false;
  String? hasilValidasiAI;

  final String _apiKey =  dotenv.env['AQ.Ab8RN6JE5KyoTYJUSCB0TRzRiZ6Yf0BA01WKB27Ad15n_d44ng'] ?? '';

  Future<void> _pilihFotoTugas() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fotoTugasSiswa = File(pickedFile.path);
        hasilValidasiAI = null;
      });
    }
  }
  Future<void> _validasiTugasDenganAI()async {
    if(_fotoTugasSiswa == null) return;

    setState(() {
      _sedangMengecek = true;
    });
    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
      );
        final prompt = '''
      Anda adalah asisten guru yang bertugas memeriksa kelengkapan dan kesesuaian pengumpulan tugas siswa.
      
      Instruksi Tugas yang Diminta:
      - Halaman, Materi/Tentang: $halamanTugas
       
      
      Tugas Anda:
      Periksa gambar tugas yang dilampirkan oleh siswa ini. 
      1. Tentukan apakah gambar tersebut SESUAI atau TIDAK SESUAI dengan halaman dan materi yang diminta.
      2. Berikan alasan singkat yang jelas (misalnya: apakah nomor soal sudah sesuai, atau apakah halaman/materinya salah).
      
      Format balasan:
      Status: [SESUAI / TIDAK SESUAI]
      Alasan: [Penjelasan singkat]
      ''';

        final Uint8List imageBytes= await _fotoTugasSiswa!.readAsBytesSync();

        final response = await model.generateContent([
          Content.multi([
            TextPart(prompt),
            DataPart('image/jpeg', imageBytes),
          ])
        ]);
        setState(() {
          hasilValidasiAI = response.text;
        });
    } catch (e) {
      setState(() {
        hasilValidasiAI = "Terjadi Kesalahan saat Memeriksa tugas: $e";
      });
    } finally {
      setState(() {
        _sedangMengecek = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas Siswa-Siswi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:   CrossAxisAlignment.start,
            children: [
              Text("$halamanTugas", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),

              if (_fotoTugasSiswa !=null)
                Image.file(_fotoTugasSiswa!, height: 200, fit: BoxFit.cover)
           else
            Container(
           height: 150,
           width: double.infinity,
            color: Colors.grey[200],
            child: const Center(child: Text("Belum ada foto tugas yang dipilih")),
        ),
              const SizedBox(height: 16),

              if (_sedangMengecek)
                const Center(child: CircularProgressIndicator())
              else if (hasilValidasiAI !=null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: hasilValidasiAI!.contains("TIDAK SESUAI")
                        ? Colors.red[50]
                        : Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: hasilValidasiAI!.contains("TIDAK SESUAI")
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  child: Text(
                    hasilValidasiAI!,
                    style: const TextStyle(fontSize: 15),
                  ),
                )
            ],
          ),
        )
      )
    );
  }
}