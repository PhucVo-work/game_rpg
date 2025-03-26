import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/game.dart';
import 'package:game_rpg/main.dart';
import 'package:game_rpg/player/knight.dart';
import 'package:game_rpg/util/dialogs.dart';
import 'package:game_rpg/util/game_sprite_sheet.dart';

import 'map_config.dart';

class Portal extends GameDecoration with Sensor {
  final int currentMapIndex;
  bool _hasTriggered = false;

  Portal(Vector2 position, this.currentMapIndex)
      : super.withAnimation(
          animation: GameSpriteSheet.portal(),
          position: position,
          size: Vector2(tileSize * 2, tileSize * 2),
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width,
        pulseVariation: 0.1,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    final hitboxSize = Vector2(tileSize, tileSize); // Hitbox nhỏ hơn (1x1 tile)
    final hitboxPosition = Vector2(
      (size.x - hitboxSize.x) / 2, // Căn giữa theo chiều ngang
      (size.y - hitboxSize.y) / 2, // Căn giữa theo chiều dọc
    );
    add(RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
    ));
    print('Portal loaded at position: $position with index: $currentMapIndex');
    super.onLoad();
  }

  @override
  void onContact(GameComponent collision) {
    print(
        'Portal onContact triggered with: $collision'); // đọc liên tục và trả về những
    // thứ portl đang chạm vào
    if (collision is Knight && !_hasTriggered) {
      _hasTriggered = true;
      print('Collision is Knight, _hasTriggered set to true');
      int nextMapIndex = currentMapIndex + 1;
      print('Next map index calculated: $nextMapIndex');
      if (nextMapIndex < MapConfig.getMapCount()) {
        print('Map count: ${MapConfig.getMapCount()}');
        final controller = gameRef.query<GameController>().firstOrNull;
        if (controller != null) {
          print('GameController found, changing to map $nextMapIndex');
          controller.updateMap(nextMapIndex);
        } else {
          print('Error: GameController not found');
        }
      } else {
        print('No more maps, showing congratulations');
        Dialogs.showCongratulations(gameRef.context);
      }
    } else {
      print(
          'Collision ignored: Type: ${collision.runtimeType}, _hasTriggered: $_hasTriggered');
    }
  }
}
