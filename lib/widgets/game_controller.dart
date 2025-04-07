// import 'package:bonfire/bonfire.dart';
// import 'package:flutter/material.dart';
// import 'package:game_rpg/menu.dart';
// import 'package:game_rpg/util/dialogs.dart';
//
// class GameController extends GameComponent {
//   bool showGameOver = false;
//   @override
//   void update(double dt) {
//     if (checkInterval('gameOver', 100, dt)) {
//       if (gameRef.player != null && gameRef.player?.isDead == true) {
//         if (!showGameOver) {
//           showGameOver = true;
//           print('Game Over show dialog');
//           _showDialogGameOver();
//         }
//       }
//     }
//     super.update(dt);
//   }
//
//   void _showDialogGameOver() {
//     showGameOver = true;
//     Dialogs.showGameOver(
//       context,
//       () {
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => Menu()),
//           (Route<dynamic> route) => false,
//         );
//       },
//     );
//   }
// }
