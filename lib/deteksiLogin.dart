import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<void> loginUser(BuildContext context, String email, String Password) async{
  final url = Uri.parse('http://0.0.0.0:800');

  try {
    final response = await http.post(
      url,
      body: {
        'email' : email,
        'password' : password,
      },
    );
    final data = jsonDecode(response.body);

    if(response.statusCode == 200 && data ['status' == 'success']) {}
  }
}