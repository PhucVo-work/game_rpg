import 'package:bonfire/bonfire.dart';
import 'package:game_rpg/decoration/door.dart';
import 'package:game_rpg/decoration/potion_life.dart';
import 'package:game_rpg/decoration/spikes.dart';
import 'package:game_rpg/decoration/torch.dart';
import 'package:game_rpg/enemies/fire_boss.dart';
import 'package:game_rpg/enemies/goblin.dart';
import 'package:game_rpg/enemies/imp.dart';
import 'package:game_rpg/enemies/mini_boss.dart';
import 'package:game_rpg/npc/kid.dart';
import 'package:game_rpg/npc/wizard_npc.dart';

import '../decoration/key.dart';
import '../enemies/ice_boss.dart';
import '../main.dart';

class MapConfig {
  // static const double tileSize = 32;

  static final List<Map<String, dynamic>> maps = [
    {
      'path': 'tiled/map4.json',
      'bossBuilder': (Vector2 p) => IceBoss(p),
      'kidDialogues': ['talk_kid_5', 'talk_kid_6'],
      'objects': [
        'boss',
        'kid',
        'spikes',
        'key',
        'mini_boss',
        'torch_empty',
        'imp'
      ],
    },
    {
      'path': 'tiled/map.json',
      'bossBuilder': (Vector2 p) => FireBoss(p),
      'kidDialogues': ['talk_kid_3', 'talk_kid_4'],
      'objects': [
        'boss',
        'kid',
        'door',
        'torch',
        'potion',
        'wizard',
        'orc',
        'spikes',
        'imp',
        'mini_boss',
        'potion',
        'torch_empty',
        'key'
      ],
    },
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
      'door': (p) => Door(p.position, p.size),
      'torch': (p) => Torch(p.position),
      'potion': (p) => PotionLife(p.position, 30),
      'wizard': (p) => WizardNPC(p.position),
      'spikes': (p) => Spikes(p.position),
      'key': (p) => DoorKey(p.position),
      'orc': (p) => Goblin(p.position),
      'imp': (p) => Imp(p.position),
      'mini_boss': (p) => MiniBoss(p.position),
      'torch_empty': (p) => Torch(p.position, empty: true),
    };

    final Map<String, GameComponent Function(TiledObjectProperties)>
        objectsBuilder = {};
    for (var obj in objects) {
      if (defaultObjectsBuilder.containsKey(obj)) {
        objectsBuilder[obj] = defaultObjectsBuilder[obj]!;
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
