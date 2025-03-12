import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import '../../../Features/GamePlay/Entities/Player.dart';

class CustomJoystickComponent extends JoystickComponent {
  final Player player;
  final pi = 3.14;

  CustomJoystickComponent({required this.player, required Images images})
      : super(
          knob: SpriteComponent(
            sprite: Sprite(
              images.fromCache('HUD/Knob.png'),
            ),
          ),
          knobRadius: 96,
          background: SpriteComponent(
            sprite: Sprite(
              images.fromCache('HUD/Joystick.png'),
            ),
            size: Vector2.all(100),
          ),
          margin: const EdgeInsets.only(left: 48, bottom: 40),
          position: Vector2(100, 300),
        );

  @override
  void update(double dt) {
    super.update(dt);

    if (intensity > 0) {
      final angle = delta.screenAngle() - pi / 2;
      player.updateDirection(angle);
    } else {
      player.velocity = Vector2.zero();
    }
  }
}
