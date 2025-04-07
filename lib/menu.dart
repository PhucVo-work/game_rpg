import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/util/custom_sprite_animation_widget.dart';
import 'package:game_rpg/util/enemy_sprite_sheet.dart';
import 'package:game_rpg/util/localization/strings_location.dart';
import 'package:game_rpg/util/npc_sprite_sheet.dart';
import 'package:game_rpg/util/player_sprite_sheet.dart';
import 'package:game_rpg/util/sounds.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  int currentPosition = 0;
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;
  late async.Timer _timer;
  List<Future<SpriteAnimation>> sprites = [
    PlayerSpriteSheet.idleRight(),
    EnemySpriteSheet.goblinIdleRight(),
    EnemySpriteSheet.impIdleRight(),
    EnemySpriteSheet.miniBossIdleRight(),
    EnemySpriteSheet.boss1IdleRight(),
    EnemySpriteSheet.boss2IdleRight(), //*
    NpcSpriteSheet.wizardIdleLeft(),
    NpcSpriteSheet.kidIdleLeft(),
    EnemySpriteSheet.boss3IdleRight(),
    EnemySpriteSheet.maskOrcIdleRight(), //*
    EnemySpriteSheet.miniOrcIdleRight(),
    EnemySpriteSheet.orcIdleRight(),
    EnemySpriteSheet.orcShamanIdleRight(),
  ];

  @override
  void initState() {
    super.initState();
    Sounds.stopBackgroundSound();
    Sounds.stopMenuSound();
    // Hiển thị màn hình khởi động trong 3 giây, sau đó chuyển sang menu
    async.Timer(Duration(seconds: 3), () {
      setState(() {
        showSplash = false;
        Sounds.playMenuSound();
      });
      startTimer();
    });
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    // Kiểm tra xem Hive có dữ liệu currentMapIndex không
    final box = Hive.box('gameData');
    final hasSavedGame = box.containsKey('currentMapIndex') &&
        (box.get('currentMapIndex') as int) > 0;

    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'assets/gif/game_menu_animation.gif',
          fit: BoxFit.cover,
          repeat: ImageRepeat.repeat,
          width: width,
          height: height,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Ngục Tối",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (sprites.isNotEmpty)
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CustomSpriteAnimationWidget(
                      animation: sprites[currentPosition],
                    ),
                  ),
                SizedBox(
                  height: 30.0,
                ),
                // Nút Play (bắt đầu từ map 0)
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      minimumSize: Size(100, 40),
                    ),
                    child: Text(
                      getString('play_cap'),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      var savedIndex = 0;
                      box.put('currentMapIndex', savedIndex);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Game(
                              initialMapIndex: savedIndex), // Bắt đầu từ map 0
                        ),
                      );
                    },
                  ),
                ),
                // Nút Continue (nếu có dữ liệu save)
                hasSavedGame
                    ? Column(
                        children: [
                          SizedBox(height: 20),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  minimumSize: Size(100, 40),
                                  maximumSize: Size(100, 40)),
                              child: Text(
                                getString('continue_play'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Normal',
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: () {
                                final savedIndex =
                                    box.get('currentMapIndex') as int;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Game(initialMapIndex: savedIndex),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget buildSplash() {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Image.asset(
            'assets/gif/game_intro_animation.gif',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = async.Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
