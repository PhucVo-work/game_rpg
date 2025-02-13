import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Game/main_menu.dart';
import 'package:game_rpg/Game/settings.dart';

// Đặt alias để tránh xung đột với Flutter
import 'package:flame/src/components/overlay_route.dart' as FlameOverlay;

class PixelAdventure extends FlameGame {
  final musicValueNotifier = ValueNotifier<bool>(true);

  late final RouterComponent _router;

  @override
  Future<void> onLoad() async {
    _router = RouterComponent(
      initialRoute: MainMenu.id,
      routes: {
        MainMenu.id: FlameOverlay.OverlayRoute(
              (context, game) => MainMenu(
            onSettingsPressed: () {
              _router.pushNamed(Settings.id);
            },
          ),
        ),
        Settings.id: FlameOverlay.OverlayRoute(
              (context, game) => Settings(
            musicValueNotifier: musicValueNotifier,
            onBackPressed: () {
              _router.pop();
            },
          ),
        ),
      },
    );

    await add(_router);
  }
}
