import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_rpg/Game/DynamicMapManager.dart';
import 'package:game_rpg/Features/GamePlay/Entities/Player.dart';

class LobbyRoom extends World {
  final Player player;
  final String mapName;
  final String nameCharacter;
  final DynamicMapManager mapManager = DynamicMapManager();

  LobbyRoom({required this.mapName, required this.player, required this.nameCharacter});

  @override
  FutureOr<void> onLoad() async {
    // Xóa toàn bộ map trước khi load map mới
    mapManager.clearMaps();

    // Load map lobby chính
    TiledComponent lobbyScreen = await mapManager.addMap(mapName, Vector2.zero());
    add(lobbyScreen);

    // Kiểm tra và kết nối các cổng trong map
    await _connectMapGates(lobbyScreen);

    // Lấy danh sách điểm spawn từ Tiled
    final spawnPointsLayer = lobbyScreen.tileMap.getLayer<ObjectGroup>('spawnPoints');

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

  /// Kiểm tra và kết nối các cổng trong map
  Future<void> _connectMapGates(TiledComponent mapComponent) async {
    // Lấy layer gates từ map
    final gatesLayer = mapComponent.tileMap.getLayer<ObjectGroup>('gates');
    if (gatesLayer == null) return;

    // Duyệt qua từng cổng và kiểm tra kết nối
    for (final gate in gatesLayer.objects) {
      String? gateType = gate.properties.getValue<String>('type');
      String? connectedMap = gate.properties.getValue<String>('connectedMap');

      // Nếu có thông tin về map kết nối, thêm hallway và map tiếp theo
      if (gateType != null && connectedMap != null) {
        await _connectGateToMap(gate, gateType, connectedMap);
      }
    }
  }

  /// Kết nối cổng với map tiếp theo
  Future<void> _connectGateToMap(TiledObject gate, String gateType, String connectedMap) async {
    String hallwayName;
    Vector2 hallwayPosition;
    Vector2 nextMapPosition;

    // Xác định loại hallway và vị trí dựa trên loại cổng
    switch (gateType) {
      case 'GateTop':
        hallwayName = 'hallway_vertical';
        hallwayPosition = Vector2(gate.x - gate.width / 2, gate.y - 16 * 10);
        nextMapPosition = Vector2(hallwayPosition.x, hallwayPosition.y - 16 * 20);
        break;
      case 'GateBottom':
        hallwayName = 'hallway_vertical';
        hallwayPosition = Vector2(gate.x - gate.width / 2, gate.y + gate.height);
        nextMapPosition = Vector2(hallwayPosition.x, hallwayPosition.y + 16 * 20);
        break;
      case 'GateLeft':
        hallwayName = 'hallway_horizontal';
        hallwayPosition = Vector2(gate.x - 16 * 20, gate.y - gate.height / 2);
        nextMapPosition = Vector2(hallwayPosition.x - 16 * 20, hallwayPosition.y);
        break;
      case 'GateRight':
        hallwayName = 'hallway_horizontal';
        hallwayPosition = Vector2(gate.x + gate.width, gate.y - gate.height / 2);
        nextMapPosition = Vector2(hallwayPosition.x + 16 * 20, hallwayPosition.y);
        break;
      default:
        return;
    }

    // Thêm hallway vào map
    TiledComponent hallway = await mapManager.addMap(hallwayName, hallwayPosition);
    add(hallway);

    // Thêm map tiếp theo
    TiledComponent nextMap = await mapManager.addMap(connectedMap, nextMapPosition);
    add(nextMap);

    print("Đã kết nối cổng $gateType với hallway và map $connectedMap");
  }

  /// Xử lý khi người chơi chạm vào cổng
  void onGateTriggered(TiledObject gate) async {
    String? gateType = gate.properties.getValue<String>('type');
    String? connectedMap = gate.properties.getValue<String>('connectedMap');

    if (gateType == null) return;

    // Nếu cổng chưa được kết nối, thực hiện kết nối
    if (connectedMap != null && !_isGateConnected(gate)) {
      await _connectGateToMap(gate, gateType, connectedMap);
    }

    print("Đã chạm cổng $gateType");
  }

  /// Kiểm tra xem cổng đã được kết nối chưa
  bool _isGateConnected(TiledObject gate) {
    // Logic kiểm tra xem cổng đã được kết nối hay chưa
    // Có thể thực hiện bằng cách kiểm tra vị trí của các map đã tải
    // hoặc lưu danh sách các cổng đã kết nối

    // Đơn giản hóa: kiểm tra xem có hallway ở vị trí tương ứng không
    String? gateType = gate.properties.getValue<String>('type');
    if (gateType == null) return false;

    // Dựa vào gateType để xác định vị trí hallway
    Vector2 expectedHallwayPosition;
    switch (gateType) {
      case 'GateTop':
        expectedHallwayPosition = Vector2(gate.x - gate.width / 2, gate.y - 16 * 10);
        break;
      case 'GateBottom':
        expectedHallwayPosition = Vector2(gate.x - gate.width / 2, gate.y + gate.height);
        break;
      case 'GateLeft':
        expectedHallwayPosition = Vector2(gate.x - 16 * 20, gate.y - gate.height / 2);
        break;
      case 'GateRight':
        expectedHallwayPosition = Vector2(gate.x + gate.width, gate.y - gate.height / 2);
        break;
      default:
        return false;
    }

    // Kiểm tra xem có map nào ở vị trí này không
    for (var map in mapManager.loadedMaps) {
      if ((map.position - expectedHallwayPosition).length < 5) {
        return true;
      }
    }

    return false;
  }

  /// Khi đi hết hallway, nối với map tiếp theo
  void onHallwayExit(TiledObject exitGate) async {
    String? nextMap = exitGate.properties.getValue<String>('nextMap');
    if (nextMap == null) return;

    Vector2 nextMapPosition = Vector2(exitGate.x, exitGate.y);

    // Kiểm tra xem map đã được tải chưa
    bool mapExists = false;
    for (var map in mapManager.loadedMaps) {
      if (mapManager.mapNames[map] == nextMap) {
        mapExists = true;
        break;
      }
    }

    // Nếu map chưa tồn tại, thêm mới
    if (!mapExists) {
      TiledComponent newMap = await mapManager.addMapByName(nextMap, nextMapPosition);
      add(newMap);
      print("Đã thêm map mới: $nextMap");
    }
  }
}