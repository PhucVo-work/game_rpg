import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:game_rpg/Game/GameWorld.dart';
import 'package:game_rpg/Presentation/Screens/main_menu.dart';
import 'package:game_rpg/Presentation/Widgets/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Khởi tạo Firebase
  FirebaseAuth.instance.setLanguageCode('vi');
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GameWorld(); // Tạo game trước khi truyền vào GameWidget

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game RPG',
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          MainMenu.id: (context, _) =>
              MainMenu(onSettingsPressed: game.showSettings),
          Settings.id: (context, _) => Settings(
            musicValueNotifier: game.musicValueNotifier,
            onBackPressed: game.hideSettings,
          ),
        },
        initialActiveOverlays: const [MainMenu.id],
      ),
    );
  }
}
