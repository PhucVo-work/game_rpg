import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class LobbyGame extends FlameGame {
  late TiledComponent lobbyScreen;

  @override
  FutureOr<void> onLoad() async {
    lobbyScreen = await TiledComponent.load('test-game.tmx', Vector2.all(16));
    add(lobbyScreen);

    return super.onLoad();
  }

  // thêm nhân vật vào phòng chờ sau này
}
