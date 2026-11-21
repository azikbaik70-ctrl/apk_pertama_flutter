import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Fungsi untuk login menggunakan akun Google
  static Future<GoogleAuthResult> signInWithGoogle() async {
    try {
      // 1. Bersihkan sesi lama di HP
      try {
        await _googleSignIn.signOut();
      } catch (_) {}

      // 2. Memicu dialog pemilih akun Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return GoogleAuthResult(
          isSuccess: false,
          message: "Proses login Google dibatalkan.",
        );
      }

      // 3. LANGSUNG BERHASIL MASUK DENGAN NAMA & EMAIL AKUN GOOGLE
      return GoogleAuthResult(
        isSuccess: true,
        message: "Login Google Berhasil!",
        userData: {
          "user": {
            "nama": googleUser.displayName ?? googleUser.email.split('@')[0],
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
