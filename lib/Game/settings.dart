import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const id = 'settings'; // ✅ Thêm ID để định danh route

  final ValueNotifier<bool> musicValueNotifier;
  final VoidCallback onBackPressed;

  const Settings({
    super.key,
    required this.musicValueNotifier,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: musicValueNotifier,
              builder: (context, isMusicOn, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Music',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Switch(
                      value: isMusicOn,
                      onChanged: (value) {
                        musicValueNotifier.value = value;
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onBackPressed,
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
