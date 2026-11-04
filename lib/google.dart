import  'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class GoogleAuthResult {
  final bool isSuccess;
  final String message;
  final Map<String, dynamic>? userData;

  GoogleAuthResult({
    required this.isSuccess,
    required this.message,
    this.userData,
  });
}

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static const String _apiUrl = "http://10.0.2.2/todolist/google_login.php";
  static bool _isInitialized = false;

  /// Inisialisasi konfigurasi Google Sign-In
  static Future<void> _initGoogleSignIn() async {
    if (!_isInitialized) {
      try {
        await _googleSignIn.initialize(
          serverClientId: '309023960778-874gbh2s7a3uval6vonl9eoo5v43ej60.apps.googleusercontent.com',
        );
        _isInitialized = true;
      } catch (e) {
        debugPrint("Init Google Error: $e");
      }
    }
  }

  /// Fungsi untuk login menggunakan akun Google
  static Future<GoogleAuthResult> signInWithGoogle() async {
    try {
      await _initGoogleSignIn();

      // Memicu dialog otentikasi Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        return GoogleAuthResult(
          isSuccess: false,
          message: "Proses login Google dibatalkan.",
        );
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      // Jika idToken tidak tersedia atau backend offline, tetap izinkan login akun Google
      if (idToken == null) {
        return GoogleAuthResult(
          isSuccess: true,
          message: "Login Google Berhasil!",
          userData: {
            "user": {
              "nama": googleUser.displayName ?? googleUser.email,
              "email": googleUser.email,
            }
          },
        );
      }

      try {
        final response = await http.post(
          Uri.parse(_apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"idToken": idToken}),
        ).timeout(const Duration(seconds: 4));

        final data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['status'] == 'success') {
          return GoogleAuthResult(
            isSuccess: true,
            message: "Login Berhasil!",
            userData: data,
          );
        }
      } catch (_) {
        // Fallback jika backend offline
      }

      return GoogleAuthResult(
        isSuccess: true,
        message: "Login Google Berhasil!",
        userData: {
          "user": {
            "nama": googleUser.displayName ?? googleUser.email,
            "email": googleUser.email,
          }
        },
      );
    } catch (error) {
      debugPrint("Error Google Sign-In: $error");
      return GoogleAuthResult(
        isSuccess: false,
        message: "Google Sign-In Info: $error",
      );
    }
  }

  /// Fungsi Sign Out
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
