import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Home extends World {

  late TiledComponent home;

  @override
  FutureOr<void> onLoad() async {
    home = await TiledComponent.load('test-game.tmx', Vector2.all(16));

    add(home);

    return super.onLoad();
  }

}