import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/decoration/door.dart';
import 'package:game_rpg/decoration/key.dart';
import 'package:game_rpg/decoration/potion_life.dart';
import 'package:game_rpg/decoration/spikes.dart';
import 'package:game_rpg/decoration/torch.dart';
import 'package:game_rpg/enemies/boss.dart';
import 'package:game_rpg/enemies/goblin.dart';
import 'package:game_rpg/enemies/imp.dart';
import 'package:game_rpg/enemies/mini_boss.dart';
import 'package:game_rpg/interface/knight_interface.dart';
import 'package:game_rpg/main.dart';
import 'package:game_rpg/npc/kid.dart';
import 'package:game_rpg/npc/wizard_npc.dart';
import 'package:game_rpg/player/knight.dart';
import 'package:game_rpg/util/sounds.dart';
import 'package:game_rpg/widgets/game_controller.dart';

class Game extends StatefulWidget {
  static bool useJoystick = true;
  const Game({Key? key}) : super(key: key);

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  @override
  void initState() {
    Sounds.playBackgroundSound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
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
        )
      ],
    );

    // xóa chức năng bàn phím
    // if (!Game.useJoystick) {
    //   joystick = Keyboard(
    //     config: KeyboardConfig(
    //       directionalKeys: [KeyboardDirectionalKeys.arrows()],
    //       acceptedKeys: [
    //         LogicalKeyboardKey.space,
    //         LogicalKeyboardKey.keyZ,
    //       ],
    //     ),
    //   );
    // }

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        playerControllers: [
          joystick,
        ],
        player: Knight(
          Vector2(2 * tileSize, 3 * tileSize),
        ),
        map: WorldMapByTiled(
          WorldMapReader.fromAsset('tiled/island.json'),
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'door': (p) => Door(p.position, p.size),
            'torch': (p) => Torch(p.position),
            'potion': (p) => PotionLife(p.position, 30),
            'wizard': (p) => WizardNPC(p.position),
            'spikes': (p) => Spikes(p.position),
            'key': (p) => DoorKey(p.position),
            'kid': (p) => Kid(p.position),
            'boss': (p) => Boss(p.position),
            'orc': (p) => Goblin(p.position),
            'imp': (p) => Imp(p.position),
            'mini_boss': (p) => MiniBoss(p.position),
            'torch_empty': (p) => Torch(p.position, empty: true),
          },
        ),
        components: [GameController()],
        interface: KnightInterface(),
        lightingColorGame: Colors.deepOrangeAccent
            .withOpacity(0.2), //Colors.black.withOpacity(0.6),
        backgroundColor: Colors.grey[900]!,
        cameraConfig: CameraConfig(
          speed: 3,
          zoom: getZoomFromMaxVisibleTile(context, tileSize, 18),
        ),
        overlayBuilderMap: {
          'miniMap': (context, game) => MiniMap(
                game: game,
                margin: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(10),
                size: Vector2.all(
                  150,
                ),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
        },
        initialActiveOverlays: const [
          'miniMap',
        ],
        // progress: Container(
        //   color: Colors.black,
        //   child: Center(
        //     child: Text(
        //       "Loading...",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'Normal',
        //         fontSize: 20.0,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
