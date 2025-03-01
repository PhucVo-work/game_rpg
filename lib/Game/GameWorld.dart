import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Presentation/Screens/main_menu.dart';
import 'package:game_rpg/Presentation/Widgets/settings.dart';

class GameWorld extends FlameGame {
  final musicValueNotifier = ValueNotifier<bool>(true);

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask Dude/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask Dude/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Ninja Frog/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Ninja Frog/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Pink Man/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Pink Man/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Virtual Guy/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Virtual Guy/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask/Idle (32x32).png',
      'HUD/Knob.png',
      'HUD/Joystick.png',
    ]);

    overlays.add(MainMenu.id);
  }

  void showSettings() {
    overlays.add(Settings.id);
  }

  void hideSettings() {
    overlays.remove(Settings.id);
  }
}
