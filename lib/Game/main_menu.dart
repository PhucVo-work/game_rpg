import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Game/google_sign_in_service.dart';

class MainMenu extends StatelessWidget {
  static const String id = 'MainMenu';
  final VoidCallback? onSettingsPressed;

  const MainMenu({super.key, this.onSettingsPressed});

  Future<void> _signInWithGoogle(BuildContext context) async {
    UserCredential? userCredential = await GoogleSignInService.signInWithGoogle();
    if (userCredential != null) {
      Navigator.pushNamed(context, 'lobby'); // Điều hướng đến sảnh chờ
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Menu/dungeonbg4.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nút cài đặt
          Positioned(
            top: 10,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.settings, size: 50, color: Colors.white),
              onPressed: onSettingsPressed,
            ),
          ),
          // Nút Sign in with Google
          Center(
            child: SizedBox(
              width: 300,
              child: OutlinedButton(
                onPressed: () => _signInWithGoogle(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Menu/google_icon.png', height: 24),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
