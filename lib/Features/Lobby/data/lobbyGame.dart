// lobby_game.dart
import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/Features/lobby/data/lobbyRoom.dart';
import 'package:game_rpg/Game/Camera.dart';

class LobbyGame extends FlameGame {
  late final CameraComponent cam;
  final world = LobbyRoom();

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Ninja Frog/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Ninja Frog/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask Dude/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Mask Dude/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Pink Man/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Pink Man/Run (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Virtual Guy/Idle (32x32).png',
      'Environment/Dungeon_Prison/Assets/Characters/Main Characters/Virtual Guy/Run (32x32).png',
    ]);

    await images.loadAllImages();

    cam = GameCamera(world: world);
    addAll([world, cam]);
    return super.onLoad();
  }
}