import 'package:flame/components.dart';
import '../../../Features/GamePlay/Entities/player.dart';
import '../../../Presentation/Widgets/HUD/JoystickComponent.dart';

class HUD extends PositionComponent with HasGameRef {
  final Player player;
  late final CustomJoystickComponent joystick;

  HUD({required this.player}) : super(priority: 1000);

  @override
  Future<void> onLoad() async {
    // Đợi cho đến khi HasGameRef được khởi tạo đầy đủ
    await super.onLoad();

    // Thiết lập kích thước của HUD bằng kích thước màn hình
    size = gameRef.size;

    // Debug để kiểm tra HUD có được thêm vào không
    print("HUD đang được khởi tạo với kích thước: $size");

    // Tạo joystick và thêm vào HUD
    try {
      joystick =
          CustomJoystickComponent(player: player, images: gameRef.images);
      print("Joystick đã được tạo");
      add(joystick);
      print("Joystick đã được thêm vào HUD");
    } catch (e) {
      print("Lỗi khi tạo hoặc thêm joystick: $e");
    }

    return;
  }
}
