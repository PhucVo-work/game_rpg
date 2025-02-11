import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/state/home.dart';

class PixelAdventure extends FlameGame{
  @override
  Color backgroundColor() => const Color(0x000000);
  late final CameraComponent cam;

  final world = Home();

  @override
  FutureOr<void> onLoad() {

    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    return super.onLoad();
  }

}