import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class GameCamera extends CameraComponent {
  GameCamera({required World world, double width = 640, double height = 360})
      : super.withFixedResolution(
    world: world,
    width: width,
    height: height,
  ) {
    viewfinder.anchor = Anchor.topLeft;
  }
}
