import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Features/Lobby/data/lobbyGame.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sảnh Chờ"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GameWidget(game: LobbyGame()),
    );
  }
}
