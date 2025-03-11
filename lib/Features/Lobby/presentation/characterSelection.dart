import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/Features/Lobby/presentation/lobbyScreen.dart';

import '../../GamePlay/Entities/character_assest.dart';

enum CharacterState { idle }

class CharacterSelectionWidget extends StatefulWidget {
  @override
  _CharacterSelectionWidgetState createState() =>
      _CharacterSelectionWidgetState();
}

class _CharacterSelectionWidgetState extends State<CharacterSelectionWidget> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(
    viewportFraction: 0.3,
    initialPage: 0,
  );
  SpriteAnimationGroupComponent<CharacterState>? _spriteAnimation;
  final double stepTime = 0.050;
  final int totalFrames = 8;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSpriteAnimation(_selectedIndex);

    // Thêm listener cho pageController để cập nhật selectedIndex
    _pageController.addListener(() {
      // int currentPage = _pageController.page!.round();
      // if (currentPage != _selectedIndex) {
      //   _loadSpriteAnimation(currentPage);
      // }
      int currentPage = _pageController.page!.round();
      if (currentPage != _selectedIndex) {
        if (currentPage == characterAssets.length - 1 && _selectedIndex == 0) {
          _pageController.jumpToPage(0); // Quay lại đầu khi đạt cuối
        } else if (currentPage == 0 &&
            _selectedIndex == characterAssets.length - 1) {
          _pageController
              .jumpToPage(characterAssets.length - 1); // Quay cuối khi đạt đầu
        }
        _loadSpriteAnimation(currentPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadSpriteAnimation(int index) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final spriteImage = await Flame.images
          .load('${characterAssets[index].assetPath}/Idle (40x40).png');

      final idleAnimation = SpriteAnimation.fromFrameData(
        spriteImage,
        SpriteAnimationData.sequenced(
          amount: totalFrames,
          stepTime: stepTime,
          textureSize: Vector2.all(40),
        ),
      );

      if (mounted) {
        setState(() {
          _spriteAnimation = SpriteAnimationGroupComponent<CharacterState>(
            animations: {CharacterState.idle: idleAnimation},
            current: CharacterState.idle,
            size: Vector2.all(40),
            anchor: Anchor.center,
          );
          _selectedIndex = index;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Lỗi khi tải animation: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onArrowPressed(int direction) {
    int newIndex = (_selectedIndex + direction + characterAssets.length) %
        characterAssets.length;
    _pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/backGround_IMG/dugeonbg4.png',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.8)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Character name - Hàng 1
              Text(
                characterAssets[_selectedIndex].name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Character animation - Hàng 2
              Container(
                height: 0,
                child: Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: screenSize.width * 0.4,
                    height: screenSize.height * 0.55,
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow,
                            ),
                          )
                        : _spriteAnimation != null
                            ? Transform.scale(
                                scale: 2.7,
                                child: GameWidget(
                                  game: CharacterGame(
                                      animation: _spriteAnimation!),
                                ),
                              )
                            : SizedBox(),
                  ),
                ),
              ),
              SizedBox(
                height: 2.5,
              ),
              // Character carousel - Hàng 3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _onArrowPressed(-1),
                    icon: Icon(
                      Icons.arrow_left, // Sử dụng icon tam giác mũi tên trái
                      size: 80, // Phóng to kích thước icon
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.18,
                    width: screenSize.height * 0.7,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: characterAssets.length,
                      itemBuilder: (context, index) {
                        bool isSelected = index == _selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            // Nhảy đến index được chọn
                            _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            // Cập nhật selectedIndex
                            _loadSpriteAnimation(index);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: isSelected ? 0 : 4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.grey.withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 54, // Nền 60x60
                                height: 54, // Nền 60x60
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.greenAccent.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  characterAssets[index].picturePath,
                                  width: 40, // Ảnh 40x40
                                  height: 40, // Ảnh 40x40
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onArrowPressed(1),
                    icon: Icon(
                      Icons.arrow_right, // Sử dụng icon tam giác mũi tên phải
                      size: 80, // Phóng to kích thước icon
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Start button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LobbyScreen(
                        nameCharacter: characterAssets[_selectedIndex].name,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.08,
                    vertical: screenSize.height * 0.010,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Bắt đầu',
                  style: TextStyle(
                    color: Colors.white,
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
  final SpriteAnimationGroupComponent<CharacterState> animation;

  CharacterGame({required this.animation});

  @override
  Future<void> onLoad() async {
    add(animation);
  }

  @override
  void onMount() {
    super.onMount();
    animation.position = size / 2;
  }
}
