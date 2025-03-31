import 'package:bonfire/bonfire.dart';
import 'package:game_rpg/decoration/door.dart';
import 'package:game_rpg/decoration/potion_life.dart';
import 'package:game_rpg/decoration/spikes.dart';
import 'package:game_rpg/decoration/torch.dart';
import 'package:game_rpg/enemies/boss1.dart';
import 'package:game_rpg/enemies/goblin.dart';
import 'package:game_rpg/enemies/imp.dart';
import 'package:game_rpg/enemies/mini_boss.dart';
import 'package:game_rpg/npc/kid.dart';
import 'package:game_rpg/npc/wizard_npc.dart';

import '../decoration/key.dart';
import '../enemies/MaskOrc.dart';
import '../enemies/MiniOrc.dart';
import '../enemies/Orc.dart';
import '../enemies/OrcShaman.dart';
import '../enemies/boss2.dart';
import '../enemies/boss3.dart';
import '../main.dart';

class MapConfig {
  static final List<Map<String, dynamic>> maps = [
    {
      'path': 'tiled/map4.json',
      'bossBuilder': (Vector2 p) => Boss1(p),
      'kidDialogues': ['talk_kid_3', 'talk_kid_4', 'talk_player_4'],
      'wizardDialogues': [
        'talk_wizard_1',
        'talk_player_1',
        'talk_wizard_2',
        'talk_player_2',
        'talk_wizard_3',
      ],
      'objects': [
        'boss',
        'kid',
        'wizard',
        'goblin',
        'mask_orc',
        'mini_orc',
        'potion'
      ],
    },
    {
      'path': 'tiled/map5.json',
      'bossBuilder': (Vector2 p) => Boss2(p),
      'kidDialogues': ['talk_kid_5', 'talk_kid_6', 'talk_player_8'],
      'wizardDialogues': [
        'talk_wizard_4',
        'talk_player_5',
        'talk_wizard_5',
        'talk_player_6',
        'talk_wizard_6',
      ],
      'objects': [
        'boss',
        'kid',
        'wizard',
        'key',
        'torch_empty',
        'orc',
        'orc_shaman',
        'mini_boss',
        'spikes',
        'door',
      ],
    },
    {
      'path': 'tiled/map6.json',
      'bossBuilder': (Vector2 p) => Boss3(p),
      'kidDialogues': ['talk_kid_10', 'talk_kid_10', 'talk_player_11'],
      'objects': [
        'boss',
        'kid',
        'key',
        'door',
        'imp',
        'torch_empty',
        'torch',
        'goblin',
        'spikes',
        'potion'
      ],
    },
    // {
    //   'path': 'tiled/map1.json',
    //   'bossBuilder': (Vector2 p) => Boss1(p),
    //   'kidDialogues': ['talk_kid_3', 'talk_kid_4', 'talk_player_4'],
    //   'wizardDialogues': [
    //     'talk_wizard_1',
    //     'talk_player_1',
    //     'talk_wizard_2',
    //     'talk_player_2',
    //     'talk_wizard_3',
    //   ],
    //   'objects': [
    //     'boss',
    //     'kid',
    //     'wizard',
    //     'mini_orc',
    //     'mask_orc',
    //     'torch',
    //     'empty_torch',
    //     'mini_orc',
    //     'spikes',
    //     'key',
    //     'door',
    //     'potion',
    //   ],
    // },
    // {
    //   'path': 'tiled/map2.json',
    //   'bossBuilder': (Vector2 p) => Boss1(p),
    //   'kidDialogues': ['talk_kid_3', 'talk_kid_4', 'talk_player_4'],
    //   'wizardDialogues': [
    //     'talk_wizard_1',
    //     'talk_player_1',
    //     'talk_wizard_2',
    //     'talk_player_2',
    //     'talk_wizard_3',
    //   ],
    //   'objects': [
    //     'boss',
    //     'kid',
    //     'door',
    //     'wizard',
    //     'key',
    //     'spikes',
    //     'orc',
    //     'orc_shaman',
    //     'potion',
    //     'mini_boss',
    //     'torch',
    //     'empty_torch'
    //   ],
    // },
    // {
    //   'path': 'tiled/map.json',
    //   'bossBuilder': (Vector2 p) => Boss2(p),
    //   'kidDialogues': ['talk_kid_5', 'talk_kid_6', 'talk_player_8'],
    //   'wizardDialogues': [
    //     'talk_wizard_4',
    //     'talk_player_5',
    //     'talk_wizard_5',
    //     'talk_player_6',
    //     'talk_wizard_6',
    //   ],
    //   'objects': [
    //     'boss',
    //     'kid',
    //     'wizard',
    //     'door',
    //     'key',
    //     'potion',
    //     'goblin',
    //     'spikes',
    //     'orc',
    //     'mini_boss',
    //     'torch',
    //     'torch_empty',
    //     'imp'
    //   ],
    // },
    // {
    //   'path': 'tiled/map3.json',
    //   'bossBuilder': (Vector2 p) => Boss3(p),
    //   'kidDialogues': ['talk_kid_10', 'talk_kid_11', 'talk_player_11'],
    //   'objects': [
    //     'boss',
    //     'kid',
    //     'potion',
    //     'key',
    //     'torch',
    //     'door',
    //     'spikes',
    //     'potion',
    //     'goblin',
    //     'mini_boss',
    //     'empty_torch',
    //     'imp'
    //   ],
    // },
  ];

  static WorldMapByTiled? getMap(int index) {
    if (index >= maps.length) return null;
    final mapData = maps[index];
    print('Loading map: ${mapData['path']}'); // Debug
    final objects = mapData['objects'] as List<String>;

    if (!objects.contains('boss') || !objects.contains('kid')) {
      throw Exception('Map $index must contain "boss" and "kid"');
    }

    final Map<String, GameComponent Function(TiledObjectProperties)>
        defaultObjectsBuilder = {
      'boss': (p) => mapData['bossBuilder'](p.position),
      'kid': (p) => Kid(p.position, index),
      'key': (p) => DoorKey(p.position),
      'potion': (p) => PotionLife(p.position, 30),
      'door': (p) => Door(p.position, p.size),
      'torch': (p) => Torch(p.position),
      'wizard': (p) => WizardNPC(p.position, index),
      'spikes': (p) => Spikes(p.position),
      'goblin': (p) => Goblin(p.position),
      'imp': (p) => Imp(p.position),
      'mini_boss': (p) => MiniBoss(p.position),
      'torch_empty': (p) => Torch(p.position, empty: true),
      'orc_shaman': (p) => OrcShaman(p.position),
      'mask_orc': (p) => MaskOrc(p.position),
      'mini_orc': (p) => MiniOrc(p.position),
      'orc': (p) => Orc(p.position),
    };

    final Map<String, GameComponent Function(TiledObjectProperties)>
        objectsBuilder = {};
    for (var obj in objects) {
      if (defaultObjectsBuilder.containsKey(obj)) {
        print('${obj}');
        objectsBuilder[obj] = defaultObjectsBuilder[obj]!;
        print('${objectsBuilder[obj]}');
      }
    }

    return WorldMapByTiled(
      WorldMapReader.fromAsset(mapData['path']),
      forceTileSize: Vector2(tileSize, tileSize),
      objectsBuilder: objectsBuilder,
    );
  }

  static int getMapCount() {
    print('Map count: ${maps.length}'); // Debug
    return maps.length;
  }
}
