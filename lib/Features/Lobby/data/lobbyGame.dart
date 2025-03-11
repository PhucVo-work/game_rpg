// import 'dart:async';
//
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:game_rpg/Features/GamePlay/Entities/player.dart';
// import 'package:game_rpg/Features/lobby/data/lobbyRoom.dart';
// import 'package:game_rpg/Game/Camera.dart';
//
// import '../../../Presentation/Widgets/HUD/Hud.dart';
//
// class LobbyGame extends FlameGame with DragCallbacks {
//   final String nameCharacter;
//   LobbyGame({required this.nameCharacter});
//   late final CameraComponent cam;
//   late HUD hud;
//   late final Player player;
//
//   @override
//   Future<void> onLoad() async {
//     // Tạo player
//     player = Player(character: nameCharacter);
//
//     if (player != null) {
//       hud = HUD(player: player!);
//       add(hud);
//     }
//
//     // Tạo thế giới và camera
//     final world = LobbyRoom(
//         mapName: 'test-game', player: player, nameCharacter: nameCharacter);
//     cam = GameCamera(world: world);
//     cam.priority = 10;
//
//     addAll([world, cam]);
//
//     // Gắn camera theo dõi player
//     camera.followComponent(player,
//         worldBounds: Rect.fromLTRB(
//           0,
//           0,
//           world.lobbyScreen.size.x,
//           world.lobbyScreen.size.y,
//         ));
//
//     return super.onLoad();
//   }
// }

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/Features/GamePlay/Entities/player.dart';
import 'package:game_rpg/Features/lobby/data/lobbyRoom.dart';
import 'package:game_rpg/Game/Camera.dart';

import '../../../Presentation/Widgets/HUD/Hud.dart';

class LobbyGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  final String nameCharacter;
  LobbyGame({required this.nameCharacter});

  late final GameCamera cam;
  late HUD hud;
  late final Player player;

  @override
  Future<void> onLoad() async {
    // Tạo player
    player = Player(character: nameCharacter);

    if (player != null) {
      hud = HUD(player: player);
      add(hud);
    }

    // Tạo thế giới
    final world = LobbyRoom(
        mapName: 'test-game', player: player, nameCharacter: nameCharacter);
    add(world);

    // Tạo camera và thiết lập theo dõi player
    cam = GameCamera(world: world);
    cam.priority = 10;
    cam.followTarget(player); // Camera follow player

    add(cam);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Các logic cập nhật khác nếu cần
  }
}
