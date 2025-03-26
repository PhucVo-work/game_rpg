import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final BonfireGame game;

  const PauseMenu({Key? key, required this.game}) : super(key: key);

  static const String overlayKey = 'pauseMenu';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 400,
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Paused',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.paused = false; // Tiếp tục game
                game.overlays.remove(overlayKey); // Ẩn menu
              },
              child: const Text('Resume'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                game.paused = false; // Reset trạng thái pause
                Navigator.of(context).pop(); // Quay lại màn hình chính (nếu có)
              },
              child: const Text('Quit'),
            ),
          ],
        ),
      ),
    );
  }
}