import 'dart:math' as math;

import 'package:flame/components.dart';

class GameCamera extends CameraComponent {
  GameCamera({required World world, double width = 640, double height = 360})
      : super.withFixedResolution(
          world: world,
          width: width,
          height: height,
        ) {
    viewfinder.anchor = Anchor.center; // Đặt tâm camera làm gốc
  }

  late PositionComponent _target;

  /// Bắt đầu theo dõi đối tượng
  void followTarget(PositionComponent target) {
    _target = target;
  }

  /// Cập nhật camera mỗi khung hình
  @override
  void update(double dt) {
    super.update(dt);

    if (_target != null) {
      // Làm mượt vị trí camera bằng nội suy
      const double smoothness = 3.0; // Tăng giá trị này để làm mượt hơn
      viewfinder.position = Vector2(
        math.max(
          0,
          viewfinder.position.x +
              ((_target.position.x - viewfinder.position.x) * dt * smoothness),
        ),
        math.max(
          0,
          viewfinder.position.y +
              ((_target.position.y - viewfinder.position.y) * dt * smoothness),
        ),
      );
    }
  }
}
