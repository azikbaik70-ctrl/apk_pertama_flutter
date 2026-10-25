import 'dart:ui';
import 'dart:convert';
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
import 'package:apk_pertama/main.dart';

class AppRouters {
  static const String login= '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes =>  {
    login: (context) => const loginpage(),
    register: (context) => const registerPage(),
    home: (context) => const HalamanUtama(),
  };
}