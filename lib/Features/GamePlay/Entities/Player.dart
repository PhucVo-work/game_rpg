import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_rpg/Features/Lobby/data/lobbyGame.dart';

enum PlayerState {
  idle,
  running,
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<LobbyGame>  {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.5;
  final int amount = 4;
  @override
  FutureOr<void> onLoad() {
    try {
      _loadAnimations();
      print('Player animations loaded successfully!');
    } catch (e) {
      print('Error loading Player animations: $e');
    }
    return super.onLoad();
  }

  void _loadAnimations() {
    idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Environment/Dungeon_Prison/Assets/Characters/Knight_10/Knight_10_Walk_DownF0.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ),
    );
    runningAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Environment/Dungeon_Prison/Assets/Characters/Knight_10/Knight_10_Walk_Right.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    //set current animation
    current = PlayerState.idle;

  }
}