import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/interface/knight_interface.dart';
import 'package:game_rpg/player/knight.dart';
import 'package:game_rpg/util/map_config.dart';
import 'package:game_rpg/util/sounds.dart';

import 'interface/pause_menu.dart';
import 'main.dart';

class Game extends StatefulWidget {
  static bool useJoystick = true;
  final int initialMapIndex;

  const Game({Key? key, required this.initialMapIndex}) : super(key: key);

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  int currentMapIndex = 0;
  late WorldMapByTiled currentMap;

  @override
  void initState() {
    super.initState();
    currentMapIndex = widget.initialMapIndex;
    currentMap = MapConfig.getMap(currentMapIndex)!;
    Sounds.playBackgroundSound();
    print('Game initialized with map index: $currentMapIndex');
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  void updateMapIndex(int newIndex) {
    print('Updating map index to: $newIndex');
    setState(() {
      currentMapIndex = newIndex;
      currentMap = MapConfig.getMap(currentMapIndex)!;
      print(
          'New map prepared for index: $currentMapIndex, rebuilding BonfireWidget');
    });
  }

  @override
  Widget build(BuildContext context) {
    PlayerController joystick = Joystick(
      directional: JoystickDirectional(
        spriteBackgroundDirectional: Sprite.load('Joystick.png'),
        spriteKnobDirectional: Sprite.load('Knob.png'),
        size: 100,
        isFixed: false,
      ),
      actions: [
        JoystickAction(
          actionId: 0,
          sprite: Sprite.load('joystick_atack.png'),
          spritePressed: Sprite.load('joystick_atack_selected.png'),
          size: 80,
          margin: EdgeInsets.only(bottom: 50, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('joystick_atack_range.png'),
          spritePressed: Sprite.load('joystick_atack_range_selected.png'),
          size: 50,
          margin: EdgeInsets.only(bottom: 50, right: 160),
        ),
      ],
    );

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        key: ValueKey(
            currentMapIndex), // Thay đổi key để rebuild khi map thay đổi
        playerControllers: [joystick],
        player: Knight(Vector2(2 * tileSize, 3 * tileSize), context),
        map: currentMap,
        interface: KnightInterface(),
        lightingColorGame: Colors.black.withOpacity(0.6),
        backgroundColor: Colors.grey[900]!,
        cameraConfig: CameraConfig(
          speed: 3,
          zoom: getZoomFromMaxVisibleTile(context, tileSize, 18),
        ),
        components: [
          GameController(updateMapIndex: updateMapIndex),
        ],
        overlayBuilderMap: {
          'miniMap': (context, game) => Positioned(
                top: 20,
                right: 90,
                child: MiniMap(
                  game: game,
                  size: Vector2.all(100),
                  margin: EdgeInsets.only(right: 80, top: 20),
                  zoom: 0.6,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
              ),
          PauseMenu.overlayKey: (context, game) => PauseMenu(game: game),
          'pauseButton': (context, game) => Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    game.paused = true; // Tạm dừng game
                    game.overlays
                        .add(PauseMenu.overlayKey); // Hiển thị PauseMenu
                  },
                  child: Image.asset(
                    'assets/images/pause_button.jpg', // Path ảnh pause button
                    width: 60, // Kích thước nhỏ
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
        },
        initialActiveOverlays: const ['miniMap', 'pauseButton'],
      ),
    );
  }
}

class GameController extends GameComponent {
  final void Function(int) updateMapIndex;

  GameController({required this.updateMapIndex});

  @override
  void onMount() {
    print('GameController mounted');
    super.onMount();
  }

  void updateMap(int newIndex) {
    print('GameController updateMap called with: $newIndex');
    updateMapIndex(newIndex); // Gọi để rebuild BonfireWidget với map mới
  }
}
