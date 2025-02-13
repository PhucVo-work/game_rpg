import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/pixel_adventure.dart';
import 'package:game_rpg/Game/main_menu.dart';
import 'package:game_rpg/Game/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = PixelAdventure();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game RPG',
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          MainMenu.id: (context, _) => MainMenu(onSettingsPressed: game.showSettings),
          Settings.id: (context, _) => Settings(musicValueNotifier: game.musicValueNotifier, onBackPressed: game.hideSettings),
        },
        initialActiveOverlays: const [MainMenu.id],
      ),
    );
  }
}
