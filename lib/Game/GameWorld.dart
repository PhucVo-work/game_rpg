import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Presentation/Screens/main_menu.dart';
import 'package:game_rpg/Presentation/Widgets/settings.dart';

class GameWorld extends FlameGame {
  final musicValueNotifier = ValueNotifier<bool>(true);

  @override
  Future<void> onLoad() async {
    overlays.add(MainMenu.id);
  }

  void showSettings() {
    overlays.add(Settings.id);
  }

  void hideSettings() {
    overlays.remove(Settings.id);
  }
}