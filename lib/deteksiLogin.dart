import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> loginUser(BuildContext context, String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/login');

   try {
  final response = await http.post(
    url,
    headers: {
      'Accept': 'application/json',
      // Wajib agar Laravel selalu membalas dengan JSON
    },
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    debugPrint("Login Berhasil: $data");
    // Navigator.pushReplacementNamed(context, '/home');
  } else {
    debugPrint("Login Gagal. Status Code: ${response.statusCode}");
  }

} catch (e) {
debugPrint("Error HTTP: $e");
}
}



