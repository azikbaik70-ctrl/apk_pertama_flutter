import 'package:flutter/material.dart';
import 'package:apk_pertama/login.dart';
import 'package:apk_pertama/register.dart';
import 'package:apk_pertama/main.dart';

class AppRouters {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const loginpage(),
    register: (context) => const registerPage(),
    home: (context) => const HalamanUtama(),
  };
}
