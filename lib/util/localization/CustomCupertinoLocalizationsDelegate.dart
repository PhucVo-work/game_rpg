import 'package:flutter/cupertino.dart';

class CustomCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const CustomCupertinoLocalizations();

  @override
  String get alertDialogLabel => 'Cảnh báo';
  @override
  String get anteMeridiemAbbreviation => 'SA';
  @override
  String get postMeridiemAbbreviation => 'CH';
  @override
  String get cancelButtonLabel => 'Hủy';
  @override
  String get okButtonLabel => 'OK';
}

class CustomCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CustomCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return const CustomCupertinoLocalizations();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<CupertinoLocalizations> old) =>
      false;
}
