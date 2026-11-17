import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apk_pertama/tugas_siswa.dart';

class HalamanTugasSiswa extends StatefulWidget{
  const HalamanTugasSiswa({super.key})

  @override
  State<HalamanTugasSiswa> createState() => _HalamanTugasSiswaState();
}