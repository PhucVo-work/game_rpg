import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/util/localization/strings_location.dart';
import 'package:hive/hive.dart';

import '../game.dart';
import '../menu.dart';

class PauseMenu extends StatelessWidget {
  final BonfireGame game;

  const PauseMenu({Key? key, required this.game}) : super(key: key);

  static const String overlayKey = 'pauseMenu';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lớp phủ đen với opacity 0.5
        Container(
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
          height: double.infinity,
        ),
        // Menu chính giữa
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    final box = Hive.box('gameData');
                    final gameState =
                        context.findAncestorStateOfType<GameState>();
                    if (gameState != null) {
                      box.put('currentMapIndex', gameState.currentMapIndex);
                      print(
                          'Saved currentMapIndex: ${gameState.currentMapIndex}');
                    }
                    // game.paused = false; // Tiếp tục game
                    // game.overlays.remove(overlayKey); // Ẩn menu
                  },
                  child: Text(
                    getString("save"),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    game.resumeEngine();
                    print(
                        '${Navigator.of(game.context).toString()} pause menu quit');
                    Navigator.of(game.context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Menu()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    getString("game_out"),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Nút Close ở góc trên bên phải
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              game.paused = false; // Tiếp tục game
              game.overlays.remove(overlayKey); // Ẩn menu
            },
            child: Image.asset(
              'assets/images/close_button.jpg',
              width: 60, // Thu nhỏ
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
