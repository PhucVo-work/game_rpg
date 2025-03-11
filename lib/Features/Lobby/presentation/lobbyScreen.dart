import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Features/Lobby/data/lobbyGame.dart';

class LobbyScreen extends StatelessWidget {
  final String nameCharacter;
  const LobbyScreen({super.key, required this.nameCharacter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: LobbyGame(nameCharacter: nameCharacter)),
    );
  }
}
