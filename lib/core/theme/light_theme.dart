import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondaryContainer: Color(0xff161F1B),
    onPrimaryContainer: Color(0xffD1DAD6),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((stats) {
      if (stats.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9e9e9e);
    }),
    trackColor: WidgetStateProperty.resolveWith((stats) {
      if (stats.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Color(0xffffffff);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xff14A662)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFFFF)),
      fixedSize: WidgetStateProperty.all(Size(double.infinity, 40)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff14A662),
    foregroundColor: Color(0xffFFFFFF),
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    // from of text checkBox
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF6A6A6A),
      overflow: TextOverflow.ellipsis,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelSmall: TextStyle(color: Color(0xff161F1B), fontSize: 20),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    fillColor: Color(0xffFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black12,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff14A662),
    unselectedItemColor: Color(0xff3A4640),
    backgroundColor: Color(0xffF6F7F9),
  ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
    ),
    elevation: 2,
  ),
);
