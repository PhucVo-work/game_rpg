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
      'Environment/Dungeon_Prison/Assets/Characters/Knight_10/Knight_10_Walk_Down.png',
      'Environment/Dungeon_Prison/Assets/Characters/Knight_10/Knight_10_Walk_Right.png',
    ]);

    cam = GameCamera(world: world);
    addAll([world, cam]);
    return super.onLoad();
  }
}