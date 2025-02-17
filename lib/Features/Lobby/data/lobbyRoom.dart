import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_rpg/Features/GamePlay/Entities/Player.dart';

class LobbyRoom extends World {
  late TiledComponent lobbyScreen;

  @override
  FutureOr<void> onLoad() async {
    lobbyScreen = await TiledComponent.load('test-game.tmx', Vector2.all(16));
    add(lobbyScreen);

    // Lấy kích thước bản đồ
    final mapSize = lobbyScreen.size;

    final player = Player()
      ..position = mapSize / 2 // Đặt Player vào chính giữa
      ..anchor = Anchor.center; // Đặt điểm neo vào giữa Player

    add(player);
    return super.onLoad();
  }
}