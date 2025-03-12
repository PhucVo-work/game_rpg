import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_rpg/Features/GamePlay/Entities/Player.dart';
import 'package:game_rpg/Game/DynamicMapManager.dart';

class LobbyRoom extends World {
  final Player player;
  final String mapName;
  final String nameCharacter;
  final DynamicMapManager mapManager = DynamicMapManager();
  final Set<String> connectedGates = {}; // Lưu trạng thái các cổng đã kết nối

  LobbyRoom(
      {required this.mapName,
      required this.player,
      required this.nameCharacter});

  @override
  FutureOr<void> onLoad() async {
    // Xóa toàn bộ map trước khi load map mới
    mapManager.clearMaps();

    // Load map lobby chính
    TiledComponent lobbyScreen =
        await mapManager.addMap(mapName, Vector2.zero());
    add(lobbyScreen);

    // Kiểm tra và kết nối các cổng trong map
    await _connectMapGates(lobbyScreen);

    // Lấy danh sách điểm spawn từ Tiled
    final spawnPointsLayer =
        lobbyScreen.tileMap.getLayer<ObjectGroup>('spawnPoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        if (spawnPoint.class_ == 'Player') {
          player.character = nameCharacter;
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
        }
      }
    }
  }

  Future<void> _connectMapGates(TiledComponent mapComponent) async {
    final gatesLayer = mapComponent.tileMap.getLayer<ObjectGroup>('Gates');
    if (gatesLayer == null) {
      print("Không tìm thấy lớp Gates trong map.");
      return;
    }

    String? getPropertyByName(TiledObject object, String propertyName) {
      final property = object.properties.firstWhere(
        (p) => p.name == propertyName,
      );
      return property?.value?.toString();
    }

    for (final gate in gatesLayer.objects) {
      // Tìm thuộc tính 'type' và 'connectedMap'
      String? type = getPropertyByName(gate, 'type');
      String? connectedMap = getPropertyByName(gate, 'connectedMap');

      if (type == null || connectedMap == null) {
        print("Gate không có thuộc tính 'type' hoặc 'connectedMap'.");
        continue;
      }

      print("Đã tìm thấy gate: type = $type, connectedMap = $connectedMap");

      final gateKey = '${mapManager.mapNames[mapComponent] ?? mapName}_$type';
      if (!connectedGates.contains(gateKey)) {
        connectedGates.add(gateKey);
        await _connectGateToMap(gate, type, connectedMap);
      }
    }
  }

  /// Kết nối cổng với map tiếp theo
  Future<void> _connectGateToMap(
      TiledObject gate, String gateType, String connectedMap) async {
    String hallwayName;
    Vector2 hallwayPosition;
    Vector2 nextMapPosition;

    switch (gateType) {
      case 'GateTop':
        hallwayName = 'hallway_vertical';
        hallwayPosition = Vector2(gate.x - gate.width / 2, gate.y - 16 * 10);
        nextMapPosition =
            Vector2(hallwayPosition.x, hallwayPosition.y - 16 * 20);
        break;
      case 'GateBottom':
        hallwayName = 'hallway_vertical';
        hallwayPosition =
            Vector2(gate.x - gate.width / 2, gate.y + gate.height);
        nextMapPosition =
            Vector2(hallwayPosition.x, hallwayPosition.y + 16 * 20);
        break;
      case 'GateLeft':
        hallwayName = 'hallway_horizontal';
        hallwayPosition = Vector2(gate.x - 16 * 20, gate.y - gate.height / 2);
        nextMapPosition =
            Vector2(hallwayPosition.x - 16 * 20, hallwayPosition.y);
        break;
      case 'GateRight':
        hallwayName = 'hallway_horizontal';
        hallwayPosition =
            Vector2(gate.x + gate.width, gate.y - gate.height / 2);
        nextMapPosition =
            Vector2(hallwayPosition.x + 16 * 20, hallwayPosition.y);
        break;
      default:
        return;
    }

    // Thêm hallway và map tiếp theo
    TiledComponent hallway =
        await mapManager.addMap(hallwayName, hallwayPosition);
    add(hallway);

    TiledComponent nextMap =
        await mapManager.addMap(connectedMap, nextMapPosition);
    add(nextMap);

    // Kết nối các cổng trong map mới
    await _connectMapGates(nextMap);

    print("Đã kết nối cổng $gateType với hallway và map $connectedMap");
  }

  /// Xử lý khi người chơi chạm vào cổng
  void onGateTriggered(TiledObject gate) async {
    String? gateType = gate.properties.getValue<String>('type');
    String? connectedMap = gate.properties.getValue<String>('connectedMap');

    if (gateType == null) return;

    if (connectedMap != null && !_isGateConnected(gate)) {
      await _connectGateToMap(gate, gateType, connectedMap);
    }

    print("Người chơi đã chạm vào cổng $gateType");
  }

  /// Kiểm tra xem cổng đã được kết nối chưa
  bool _isGateConnected(TiledObject gate) {
    String? gateType = gate.properties.getValue<String>('type');
    if (gateType == null) return false;

    final gateKey = '${mapName}_$gateType';
    return connectedGates.contains(gateKey);
  }
}
