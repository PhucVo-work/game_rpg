import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/pixel_adventure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = PixelAdventure();

  runApp(GameWidget(game: game));
}