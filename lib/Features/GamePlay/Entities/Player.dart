import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:game_rpg/Features/Lobby/data/lobbyGame.dart';

enum PlayerState {
  idle,
  running,
}

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent with HasGameRef<LobbyGame> {
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final pi = 3.14;
  final double stepTime = 0.050;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

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

  @override
  void update(double dt) {
    // _updatePlayerMovement(dt);
    if (velocity.length > 0) {
      position += velocity * dt;
    } else {
      current = PlayerState.idle;
    }
    super.update(dt);
  }

  void _loadAnimations() {
    idleAnimation = _spriteAnimation('Idle', 8);
    runningAnimation = _spriteAnimation('Run', 8);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    //set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/$character/$state (40x40).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(40),
      ),
    );
  }

  void updateDirection(double angle) {
    // Determine left/right facing based on angle
    if (angle > -pi / 2 && angle < pi / 2) {
      // Right half of the circle (facing right)
      if (!isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = true;
      }
    } else {
      // Left half of the circle (facing left)
      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }
    }

    // Update velocity according to angle
    velocity = Vector2(
      cos(angle) * moveSpeed,
      sin(angle) * moveSpeed,
    );

    // Set running animation
    current = PlayerState.running;
  }
}