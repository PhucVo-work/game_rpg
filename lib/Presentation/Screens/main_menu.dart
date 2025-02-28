import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_rpg/Core/Service/google_sign_in_service.dart';
import 'package:game_rpg/Features/lobby/presentation/lobbyScreen.dart';

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

              SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () async {
                    User? user = await GoogleSignInService.signInWithGoogle(forceSignIn: true);
                    if (user != null) {
                      print("Đăng nhập thành công: ${user.displayName}");
                      // Điều hướng đến sảnh chờ và thay thế màn hình hiện tại
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LobbyScreen()),
                      );
                    } else {
                      print("Đăng nhập thất bại");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Đăng nhập thất bại")),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withAlpha((0.9 * 255).toInt()),
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Menu/google_icon.png',
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

