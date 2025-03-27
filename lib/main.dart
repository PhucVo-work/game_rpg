import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_rpg/menu.dart';
import 'package:game_rpg/util/localization/CustomCupertinoLocalizationsDelegate.dart';
import 'package:game_rpg/util/localization/my_localizations_delegate.dart';
import 'package:hive_flutter/adapters.dart';

import 'util/sounds.dart';

double tileSize = 32;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Khởi tạo Hive
  await Hive.openBox('gameData'); // Mở box để lưu trữ dữ liệu
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  await Sounds.initialize();
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Normal',
      ),
      locale: const Locale('vi', 'VN'),
      home: Menu(),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        // flutter nhận diện được vi_VN tuy nhiên CupertinoLocalizations không hỗ trợ vi_VN
        // Cụ thể, một delegate mặc định của Flutter dùng cho các widget kiểu Cupertino (iOS-style),
        // không hỗ trợ vi_VN. (hiện tại đã custom thêm bản vn) :))) Phuc Vo approve
        // DefaultCupertinoLocalizations.delegate,
        const CustomCupertinoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
    ),
  );
}
