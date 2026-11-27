import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<void> loginUser(BuildContext context, String email, String Password) async{
  final url = Uri.parse('http://127.0.0.1:8080');

  try {
    final response = await http.post(
      url,
      body: {
        'email' : email,
        'password' : password,
      },
    );
    final data = jsonDecode(response.body);

    if(response.statusCode == 200 && data ['status' == 'success']) {
      Navigator.pushReplacementNamed(context, '/home');

    } else if (data['status'] == 'not_registered') {
      _showUnregisteredDialog(context, data['message']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message'] ?? 'Terjadi Kesalahan'),
          backgroundColor: Colors.red,
        )
      );
    }
  } catch
}