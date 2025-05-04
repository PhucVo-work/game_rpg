import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/enemies/bossEntity.dart';
import 'package:game_rpg/main.dart';
import 'package:game_rpg/util/custom_sprite_animation_widget.dart';
import 'package:game_rpg/util/enemy_sprite_sheet.dart';
import 'package:game_rpg/util/game_sprite_sheet.dart';
import 'package:game_rpg/util/localization/strings_location.dart';
import 'package:game_rpg/util/npc_sprite_sheet.dart';
import 'package:game_rpg/util/player_sprite_sheet.dart';
import 'package:game_rpg/util/sounds.dart';

import 'MaskOrc.dart';
import 'mini_boss.dart';

class Boss1 extends BossEntity {
  Boss1(Vector2 position)
      : super(
          initPosition: position,
          life: 200,
          speed: tileSize * 1.5,
          size: Vector2(tileSize * 1.5, tileSize * 1.7),
          animation: EnemySpriteSheet.boss1Animations(),
          attack: 40,
        );

  @override
  void executeSkill() {
    simpleAttackMelee(
      size: Vector2.all(tileSize * 0.90),
      damage: attack,
      interval: 1500,
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void execAttackRange() {
    simpleAttackRange(
      animation: GameSpriteSheet.fireBallAttackRight(),
      animationDestroy: GameSpriteSheet.fireBallExplosion(),
      size: Vector2.all(tileSize * 0.65),
      damage: attack,
      useAngle: true,
      speed: speed * 5.0,
      execute: () => Sounds.attackRange(),
      onDestroy: () => Sounds.explosion(),
      collision: RectangleHitbox(
        size: Vector2(tileSize / 3, tileSize / 3),
        position: Vector2(10, 5),
      ),
      lightingConfig: LightingConfig(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withOpacity(0.4),
      ),
    );
  }

  @override
  void showConversation() {
    print("Boss1: _showConversation() được gọi!");
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [TextSpan(text: getString('talk_kid_1'))],
          person: CustomSpriteAnimationWidget(
              animation: NpcSpriteSheet.kidIdleLeft()),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_boss1_1'))],
          person: CustomSpriteAnimationWidget(
              animation: EnemySpriteSheet.boss1IdleRight()),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_player_3'))],
          person: CustomSpriteAnimationWidget(
              animation: PlayerSpriteSheet.idleRight()),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_boss1_2'))],
          person: CustomSpriteAnimationWidget(
              animation: EnemySpriteSheet.boss1IdleRight()),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onFinish: () {
        Sounds.interaction();
        addInitChild();
        Future.delayed(Duration(milliseconds: 500), () {
          gameRef.camera.moveToPlayerAnimated(zoom: 1);
          Sounds.playBackgroundBossSound();
        });
      },
      onChangeTalk: (index) => Sounds.interaction(),
    );
  }

  @override
  void addChildInMap(double dt) {
    if (checkInterval('addChild', 2000, dt)) {
      Vector2 positionExplosion;
      switch (directionThePlayerIsIn()) {
        case Direction.left:
          positionExplosion = position.translated(width * -2, 0);
          break;
        case Direction.right:
          positionExplosion = position.translated(width * 2, 0);
          break;
        case Direction.up:
          positionExplosion = position.translated(0, height * -2);
          break;
        case Direction.down:
          positionExplosion = position.translated(0, height * 2);
          break;
        default:
          positionExplosion = position.translated(width * 2, 0);
      }

      Enemy e = childrenEnemy.length == 2
          ? MiniBoss(positionExplosion)
          : MaskOrc(positionExplosion); // Thay Imp bằng MaskOrc

      gameRef.add(
        AnimatedGameObject(
          animation: GameSpriteSheet.smokeExplosion(),
          position: positionExplosion,
          size: Vector2(32, 32),
          loop: false,
        ),
      );
      childrenEnemy.add(e);
      gameRef.add(e);
    }
  }

  @override
  void addInitChild() {
    addMaskOrc(width * -2, 0); // Thay addImp bằng addMaskOrc
    addMaskOrc(width * -2, width);
  }

  void addMaskOrc(double x, double y) {
    final p = position.translated(x, y);
    gameRef.add(
      AnimatedGameObject(
        animation: GameSpriteSheet.smokeExplosion(),
        position: p,
        size: Vector2.all(tileSize),
        loop: false,
      ),
    );
    gameRef.add(MaskOrc(p));
  }
}
