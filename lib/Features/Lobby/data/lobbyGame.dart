import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/Features/GamePlay/Entities/Player.dart';
import 'package:game_rpg/Features/lobby/data/lobbyRoom.dart';
import 'package:game_rpg/Game/Camera.dart';

import '../../../Presentation/Widgets/HUD/Hud.dart';

class LobbyGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  final String nameCharacter;
  LobbyGame({required this.nameCharacter});
  late final CameraComponent cam;
  late HUD hud;
  Player? player;

  @override
  Future<void> onLoad() async {
    // Tạo player
    player = Player(character: nameCharacter);

    if (player != null) {
      hud = HUD(player: player!);
      add(hud);
    }

    // Tạo thế giới và camera
    final world = LobbyRoom(
        mapName: 'test-game', player: player!, nameCharacter: nameCharacter);
    cam = GameCamera(world: world);
    cam.priority = 10;

    addAll([world, cam]);

    return super.onLoad();
  }
}
