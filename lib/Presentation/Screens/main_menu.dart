import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Core/Service/google_sign_in_service.dart';

import '../../Features/Lobby/presentation/characterSelection.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final VoidCallback? onSettingsPressed;

  const MainMenu({super.key, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backGround_IMG/dugeonbg4.png'),
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

          // Nội dung chính
          Column(
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Adventure',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Nút Sign Up with Google
              SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () async {
                    User? user = await GoogleSignInService.signInWithGoogle(
                        forceSignIn: true);
                    if (user != null) {
                      print("Đăng nhập thành công: ${user.displayName}");
                      // Điều hướng đến sảnh chờ
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterSelectionWidget()),
                      );
                    } else {
                      print("Đăng nhập thất bại");
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/backGround_IMG/google_icon.png',
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign up with Google',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
