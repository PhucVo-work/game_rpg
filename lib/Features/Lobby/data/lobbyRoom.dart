import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_rpg/Features/GamePlay/Entities/player.dart';

class LobbyRoom extends World {
  final Player player;
  final String mapName;
  final String nameCharacter;

  LobbyRoom(
      {required this.mapName,
      required this.player,
      required this.nameCharacter});
  late TiledComponent lobbyScreen;

  @override
  FutureOr<void> onLoad() async {
    lobbyScreen =
        await TiledComponent.load('tiles/$mapName.tmx', Vector2.all(16));
    add(lobbyScreen);

    final spawnPointsLayer =
        lobbyScreen.tileMap.getLayer<ObjectGroup>('spawnPoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.character = nameCharacter;
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
