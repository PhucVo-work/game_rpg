import 'package:bonfire/bonfire.dart';

class EnemySpriteSheet {
  static Future<SpriteAnimation> enemyAttackEffectBottom() =>
      SpriteAnimation.load(
        'enemy/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> enemyAttackEffectLeft() =>
      SpriteAnimation.load(
        'enemy/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> enemyAttackEffectRight() =>
      SpriteAnimation.load(
        'enemy/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> enemyAttackEffectTop() => SpriteAnimation.load(
        'enemy/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  //boss1
  static Future<SpriteAnimation> boss1IdleRight() => SpriteAnimation.load(
        'enemy/boss1/boss_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(32, 36),
        ),
      );

  static SimpleDirectionAnimation boss1Animations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/boss1/boss_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        idleRight: boss1IdleRight(),
        runLeft: SpriteAnimation.load(
          'enemy/boss1/boss_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/boss1/boss_run.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
      );

  //boss2
  static Future<SpriteAnimation> boss2IdleRight() => SpriteAnimation.load(
        'enemy/boss2/boss_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(32, 36),
        ),
      );

  static SimpleDirectionAnimation boss2Animations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/boss2/boss_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/boss2/boss_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/boss2/boss_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/boss2/boss_run.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
      );

  // boss3
  static Future<SpriteAnimation> boss3IdleRight() => SpriteAnimation.load(
        'enemy/boss3/boss_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(32, 36),
        ),
      );

  static SimpleDirectionAnimation boss3Animations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/boss3/boss_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        idleRight: boss3IdleRight(),
        runLeft: SpriteAnimation.load(
          'enemy/boss3/boss_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/boss3/boss_run.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(32, 36),
          ),
        ),
      );

  //Goblin
  static Future<SpriteAnimation> goblinIdleRight() => SpriteAnimation.load(
        'enemy/goblin/goblin_idle.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation goblinAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/goblin/goblin_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/goblin/goblin_idle.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/goblin/goblin_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/goblin/goblin_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
      );

  //Mini Orc

  static Future<SpriteAnimation> miniOrcIdleRight() => SpriteAnimation.load(
        'enemy/mini_orc/mini_orc_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation miniOrcAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/mini_orc/mini_orc_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/mini_orc/mini_orc_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/mini_orc/mini_orc_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/mini_orc/mini_orc_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
      );

  // Orc
  static Future<SpriteAnimation> orcIdleRight() => SpriteAnimation.load(
        'enemy/orc/orc_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation orcAnimations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/orc/orc_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/orc/orc_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/orc/orc_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/orc/orc_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
      );

  // Orc Shaman
  static Future<SpriteAnimation> orcShamanIdleRight() => SpriteAnimation.load(
        'enemy/orc_shaman/orc_shaman_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 23),
        ),
      );

  static SimpleDirectionAnimation orcShamanAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/orc_shaman/orc_shaman_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/orc_shaman/orc_shaman_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/orc_shaman/orc_shaman_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/orc_shaman/orc_shaman_run.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
      );

  //Mask Orc
  static Future<SpriteAnimation> maskOrcIdleRight() => SpriteAnimation.load(
        'enemy/mask_orc/masked_orc_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 23),
        ),
      );

  static SimpleDirectionAnimation maskOrcAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/mask_orc/masked_orc_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/mask_orc/masked_orc_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/mask_orc/masked_orc_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/mask_orc/masked_orc_run.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 23),
          ),
        ),
      );

  static Future<SpriteAnimation> impIdleRight() => SpriteAnimation.load(
        'enemy/imp/imp_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation impAnimations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/imp/imp_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/imp/imp_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/imp/imp_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/imp/imp_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
      );

  static Future<SpriteAnimation> miniBossIdleRight() => SpriteAnimation.load(
        'enemy/mini_boss/mini_boss_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 24),
        ),
      );

  static SimpleDirectionAnimation miniBossAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/mini_boss/mini_boss_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 24),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/mini_boss/mini_boss_idle.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 24),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/mini_boss/mini_boss_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 24),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/mini_boss/mini_boss_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(16, 24),
          ),
        ),
      );
}
