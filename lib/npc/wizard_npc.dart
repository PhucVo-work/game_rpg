import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/main.dart';
import 'package:game_rpg/util/custom_sprite_animation_widget.dart';
import 'package:game_rpg/util/localization/strings_location.dart';
import 'package:game_rpg/util/npc_sprite_sheet.dart';
import 'package:game_rpg/util/player_sprite_sheet.dart';
import 'package:game_rpg/util/sounds.dart';

import '../util/map_config.dart';

class WizardNPC extends SimpleNpc {
  bool _showConversation = false;
  final int mapIndex;

  WizardNPC(Vector2 position, this.mapIndex)
      : super(
          animation: SimpleDirectionAnimation(
            idleRight: NpcSpriteSheet.wizardIdleLeft(),
            runRight: NpcSpriteSheet.wizardIdleLeft(),
          ),
          position: position,
          size: Vector2(
            tileSize * 0.8,
            tileSize,
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      this.seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_showConversation) {
            gameRef.player!.idle();
            _showConversation = true;
            _showEmote(emote: 'emote/emote_interregacao.png');
            _showIntroduction();
          }
        },
        radiusVision: (2 * tileSize),
      );
    }
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerGameObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        loop: false,
        target: this,
        offset: Vector2(18, -6),
        size: Vector2.all(tileSize / 2),
      ),
    );
  }

  void _showIntroduction() {
    Sounds.interaction();
    final dialogues =
        MapConfig.maps[mapIndex]['wizardDialogues'] as List<String>;
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(text: getString(dialogues[0])),
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[1]))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[2]))],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[3]))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString(dialogues[4]))],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
      },
    );
  }
}
