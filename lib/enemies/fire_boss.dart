import 'package:bonfire/bonfire.dart';
import 'package:game_rpg/enemies/bossEntity.dart';

import '../main.dart';

class FireBoss extends BossEntity {
  FireBoss(Vector2 position) : super(position);

  @override
  void executeSkill() {
    simpleAttackMelee(
      damage: 30,
      size: Vector2.all(tileSize),
    );
  }
}
