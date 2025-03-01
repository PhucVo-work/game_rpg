import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Features/Lobby/presentation/lobbyScreen.dart';

class CharacterSelectionWidget extends StatefulWidget {
  @override
  _CharacterSelectionWidgetState createState() =>
      _CharacterSelectionWidgetState();
}

class _CharacterSelectionWidgetState extends State<CharacterSelectionWidget> {
  int _selectedIndex = 0;
  late SpriteAnimation _spriteAnimation;
  final double stepTime = 0.05;
  final int totalFrames = 11;

  final List<String> _characters = [
    'Mask Dude',
    'Ninja Frog',
    'Pink Man',
    'Virtual Guy',
  ];

  @override
  void initState() {
    super.initState();
    _loadSpriteAnimation(_characters[_selectedIndex]);
  }

  Future<void> _loadSpriteAnimation(String character) async {
    final spriteImage = await Flame.images.load(
        'Environment/Dungeon_Prison/Assets/Characters/Main Characters/$character/Idle (32x32).png');
    setState(() {
      _spriteAnimation = SpriteAnimation.fromFrameData(
        spriteImage,
        SpriteAnimationData.sequenced(
          amount: totalFrames,
          stepTime: stepTime,
          textureSize: Vector2(32, 32),
        ),
      );
    });
  }

  void _onArrowPressed(int direction) async {
    final newIndex =
        (_selectedIndex + direction + _characters.length) % _characters.length;
    await _loadSpriteAnimation(_characters[newIndex]);
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Lớp ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/Menu/dugeonbg4.png', // Đường dẫn ảnh nền
              fit: BoxFit.cover, // Ảnh phủ toàn màn hình
            ),
          ),

          // Lớp phủ mờ màu đen
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8), // Màu đen mờ
            ),
          ),

          // Lớp nội dung chính
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Hàng 1: Hiển thị tên nhân vật
              Text(
                _characters[_selectedIndex],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Hàng 2: Hiển thị nhân vật động
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left, color: Colors.white, size: 50),
                    onPressed: () => _onArrowPressed(-1),
                  ),
                  Container(
                    height: 0,
                    width: screenSize.width * 0.3,
                    color: Colors.transparent, // Container trong suốt
                    child: _spriteAnimation != null
                        ? GameWidget(
                            game: CharacterGame(animation: _spriteAnimation),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow,
                            ),
                          ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.arrow_right, color: Colors.white, size: 40),
                    onPressed: () => _onArrowPressed(1),
                  ),
                ],
              ),
              SizedBox(height: 0.015),
              // Hàng 3: Slider hiển thị các nhân vật tĩnh
              SizedBox(
                height: screenSize.height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _characters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onArrowPressed(index - _selectedIndex),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedIndex == index
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/Environment/Dungeon_Prison/Assets/Characters/Main Characters/${_characters[index]}/Idle (32x32).png',
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.075,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LobbyScreen(
                        nameCharacter: _characters[_selectedIndex],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.08,
                    vertical: screenSize.height * 0.015,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Bắt đầu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CharacterGame extends FlameGame {
  final SpriteAnimation animation;

  CharacterGame({required this.animation});

  @override
  Future<void> onLoad() async {
    if (animation != null) {
      final screenSize = size; // Kích thước màn hình
      add(SpriteAnimationComponent()
        ..animation = animation
        ..size = Vector2(80, 80) // Kích thước nhân vật
        ..position = Vector2(
          (screenSize.x - 90) / 2, // Căn giữa chiều ngang
          (screenSize.y - 70) / 2, // Căn giữa chiều dọc
        ));
    }
  }
}
