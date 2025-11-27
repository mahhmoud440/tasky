import 'package:flutter/material.dart';

import '../services/pref_manger.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    bool result = PrefManager().getBool('themes') ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefManager().setBool('themes', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefManager().setBool('themes', true);
    }
  }
  static bool isDark() {
    return themeNotifier.value == ThemeMode.dark;
  }
}
