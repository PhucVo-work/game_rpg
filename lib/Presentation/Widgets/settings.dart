import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const id = 'Settings';
  final ValueNotifier<bool> musicValueNotifier;
  final VoidCallback? onBackPressed;

  const Settings({super.key, required this.musicValueNotifier, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Làm mờ màn hình
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Cài đặt", style: TextStyle(fontSize: 24, color: Colors.white)),
            Switch(
              value: musicValueNotifier.value,
              onChanged: (value) => musicValueNotifier.value = value,
            ),
            ElevatedButton(
              onPressed: onBackPressed,
              child: const Text("Quay lại"),
            ),
          ],
        ),
      ),
    );
  }
}
