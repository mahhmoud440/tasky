import 'package:flutter/material.dart';
import 'package:taskys/core/theme/dark_theme.dart';
import 'package:taskys/core/theme/light_theme.dart';
import 'package:taskys/core/theme/theme_controller.dart';
import 'package:taskys/screens/main_screen.dart';
import 'package:taskys/screens/welcome_screens.dart';

import '../core/services/pref_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefManager().init();
  String? username = PrefManager().getString('username');
  ThemeController().init();
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: username == null ? WelcomeScreens() : MainScreen(),
        );
      },
    );
  }
}
