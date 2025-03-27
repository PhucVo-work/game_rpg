import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_rpg/util/custom_sprite_animation_widget.dart';
import 'package:game_rpg/util/localization/strings_location.dart';
import 'package:game_rpg/util/npc_sprite_sheet.dart';

import '../enemies/bossEntity.dart';
import '../main.dart';
import '../util/map_config.dart';
import '../util/player_sprite_sheet.dart';
import '../util/portal.dart';
import '../util/sounds.dart';

class Kid extends GameDecoration {
  bool conversationWithHero = false;
  final int mapIndex;

  Kid(Vector2 position, this.mapIndex)
      : super.withAnimation(
          animation: NpcSpriteSheet.kidIdleLeft(),
          position: position,
          size: Vector2(tileSize * 0.5, tileSize * 0.7),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (!conversationWithHero && checkInterval('checkBossDead', 1000, dt)) {
      try {
        gameRef.enemies().firstWhere((e) => e is BossEntity);
      } catch (e) {
        conversationWithHero = true;
        gameRef.camera.moveToTargetAnimated(
          target: this,
          onComplete: _startConversation,
        );
      }
    }
  }

  void _startConversation() {
    final dialogues = MapConfig.maps[mapIndex]['kidDialogues'] as List<String>;
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [TextSpan(text: getString(dialogues[0]))],
          person: CustomSpriteAnimationWidget(
              animation: NpcSpriteSheet.kidIdleLeft()),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[1]))],
          person: CustomSpriteAnimationWidget(
              animation: NpcSpriteSheet.kidIdleLeft()),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[2]))],
          person: CustomSpriteAnimationWidget(
              animation: PlayerSpriteSheet.idleRight()),
          personSayDirection: PersonSayDirection.LEFT,
        )
      ],
      onFinish: () {
        Sounds.interaction(); // Thêm âm thanh
        _activatePortal();
      },
      onChangeTalk: (index) => Sounds.interaction(), // Thêm âm thanh
    );
  }

  void _activatePortal() {
    final portalPosition = position.translated(tileSize * -1.5, 15);
    print('Adding Portal at: $portalPosition'); // Debug
    gameRef.add(Portal(portalPosition, mapIndex));
  }
}
