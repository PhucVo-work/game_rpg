import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_rpg/Game/Camera.dart';


class LobbyGame extends FlameGame {
  late final GameCamera cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    // Sử dụng camera từ file camera.dart
    cam = GameCamera(world: world);
    addAll([world, cam]);

    return super.onLoad();
  }
}

class Level extends World {
  late TiledComponent lobbyScreen;

  @override
  FutureOr<void> onLoad() async {
    lobbyScreen = await TiledComponent.load('test-game.tmx', Vector2.all(16));
    add(lobbyScreen);

    return super.onLoad();
  }
}
