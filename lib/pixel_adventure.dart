import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Game/main_menu.dart';
import 'package:game_rpg/Game/settings.dart';

class PixelAdventure extends FlameGame {
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
