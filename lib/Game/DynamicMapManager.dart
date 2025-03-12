import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class DynamicMapManager {
  final List<TiledComponent> loadedMaps = [];
  final Map<TiledComponent, String> mapNames = {}; // 🔹 Lưu tên map

  /// Thêm bản đồ mới
  Future<TiledComponent> addMap(String mapName, Vector2 position) async {
    final newMap = await TiledComponent.load('$mapName.tmx', Vector2.all(16));
    newMap.position = position;
    loadedMaps.add(newMap);
    mapNames[newMap] = mapName; // 🔹 Lưu tên map vào danh sách
    return newMap;
  }

  /// Xóa một bản đồ cụ thể
  void removeMap(TiledComponent map) {
    loadedMaps.remove(map);
    mapNames.remove(map); // 🔹 Xóa tên map khỏi danh sách
    map.removeFromParent();
  }

  /// Xóa toàn bộ bản đồ
  void clearMaps() {
    for (var map in loadedMaps) {
      map.removeFromParent();
    }
    loadedMaps.clear();
    mapNames.clear();
  }

  /// Thêm bản đồ bằng tên
  Future<TiledComponent> addMapByName(String mapName, Vector2 position) async {
    return await addMap(mapName, position);
  }

  /// Xóa hallway khỏi danh sách
  void removeHallway() {
    loadedMaps.removeWhere((map) {
      final mapName = mapNames[map]; // 🔹 Lấy tên map từ danh sách
      if (mapName != null && mapName.contains('hallway')) {
        map.removeFromParent();
        mapNames.remove(map);
        return true;
      }
      return false;
    });
  }
}
