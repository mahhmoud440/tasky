import 'package:flutter/material.dart';
import 'package:taskys/core/constants/storge_key.dart';

import '../services/pref_manger.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    bool result = PrefManager().getBool(StorgeKey.themes) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefManager().setBool(StorgeKey.themes, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefManager().setBool(StorgeKey.themes, true);
    }
  }
  static bool isDark() {
    return themeNotifier.value == ThemeMode.dark;
  }
}
