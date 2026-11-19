import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apk_pertama/tugas_siswa.dart';
import 'package:apk_pertama/Upload_tugas-siswa-siswi.dart';
class HalamanTugasSiswa extends StatefulWidget{
  const HalamanTugasSiswa({super.key})

  @override
  State<HalamanTugasSiswa> createState() => _HalamanTugasSiswaState();
}
class _HalamanTugasSiswaState extends State<HalamanTugasSiswa> {
  final  halamanTugas = TugasSiswaState().masterDaftarTugas;
  final FotoTugas =  UploadTugasState().ambilFotoTugas;

  File? _fotoTugasSiswa;
  bool _sedangMengecek = false;
  String? _hasilValidasiAI;

  final String _apiKey =  dotenv.env['AQ.Ab8RN6JE5KyoTYJUSCB0TRzRiZ6Yf0BA01WKB27Ad15n_d44ng'] ?? '';

  Future<void> FotoTugas() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fotoTugasSiswa = File(pickedFile.path);
        _hasilValidasiAI = null;
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
    }
  }
}