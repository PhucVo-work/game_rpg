import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/enemies/imp.dart';
import 'package:game_rpg/enemies/mini_boss.dart';
import 'package:game_rpg/util/functions.dart';
import 'package:game_rpg/util/game_sprite_sheet.dart';

import '../main.dart';

abstract class BossEntity extends SimpleEnemy
    with BlockMovementCollision, UseLifeBar {
  final Vector2 initPosition;
  double attack;
  bool addChild = false;
  bool firstSeePlayer = false;
  List<Enemy> childrenEnemy = [];

  BossEntity({
    required this.initPosition,
    required this.attack,
    required double life,
    required double speed,
    required Vector2 size,
    required SimpleDirectionAnimation animation,
  }) : super(
          animation: animation,
          position: initPosition,
          size: size,
          speed: speed,
          life: life,
        );

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(valueByTileSize(14), valueByTileSize(16)),
        position: Vector2(valueByTileSize(5), valueByTileSize(11)),
      ),
    );
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    drawBarSummonEnemy(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (!firstSeePlayer) {
      seePlayer(
        observed: (p) {
          firstSeePlayer = true;
          print("BossEntity: Gọi _showConversation cho ${runtimeType}");
          gameRef.camera.moveToTargetAnimated(
            target: this,
            zoom: 2,
            onComplete: () => showConversation(),
          );
        },
        radiusVision: tileSize * 8,
      );
    }

    if (life < (maxLife * 0.75) && childrenEnemy.isEmpty) {
      addChildInMap(dt);
    } else if (life < (maxLife * 0.5) && childrenEnemy.length == 1) {
      addChildInMap(dt);
    } else if (life < (maxLife * 0.25) && childrenEnemy.length == 2) {
      addChildInMap(dt);
    }

    seeAndMoveToPlayer(
      closePlayer: (player) => executeSkill(),
      radiusVision: tileSize * 4,
    );

    super.update(dt);
  }

  @override
  void onDie() {
    gameRef.add(
      AnimatedGameObject(
        animation: GameSpriteSheet.explosion(),
        position: position,
        size: Vector2(32, 32),
        loop: false,
      ),
    );
    childrenEnemy.forEach((e) {
      if (!e.isDead) e.onDie();
    });
    removeFromParent();
    super.onDie();
  }

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
          : Imp(positionExplosion);

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
  void onReceiveDamage(AttackOriginEnum attacker, double damage, dynamic id) {
    print("Boss1 nhận sát thương: $damage từ $attacker. Máu hiện tại: $life");
    showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.onReceiveDamage(attacker, damage, id);
  }

  void drawBarSummonEnemy(Canvas canvas) {
    double yPosition = 0;
    double widthBar = (width - 10) / 3;
    if (childrenEnemy.length < 1) {
      canvas.drawLine(
        Offset(0, yPosition),
        Offset(widthBar, yPosition),
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 1
          ..style = PaintingStyle.fill,
      );
    }
    double lastX = widthBar + 5;
    if (childrenEnemy.length < 2) {
      canvas.drawLine(
        Offset(lastX, yPosition),
        Offset(lastX + widthBar, yPosition),
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 1
          ..style = PaintingStyle.fill,
      );
    }
    lastX += widthBar + 5;
    if (childrenEnemy.length < 3) {
      canvas.drawLine(
        Offset(lastX, yPosition),
        Offset(lastX + widthBar, yPosition),
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 1
          ..style = PaintingStyle.fill,
      );
    }
  }

  void showConversation(); // Phương thức trừu tượng cho hội thoại
  void executeSkill(); // Phương thức trừu tượng cho kỹ năng

  void addInitChild() {
    addImp(width * -2, 0);
    addImp(width * -2, width);
  }

  void addImp(double x, double y) {
    final p = position.translated(x, y);
    gameRef.add(
      AnimatedGameObject(
        animation: GameSpriteSheet.smokeExplosion(),
        position: p,
        size: Vector2.all(tileSize),
        loop: false,
      ),
    );
    gameRef.add(Imp(p));
  }
}
