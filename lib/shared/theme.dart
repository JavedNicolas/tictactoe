import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: const MaterialColor(0xFFED2161D, <int, Color>{
    50: Color(0xffd2161d),
    100: Color(0xFED2161D),
    200: Color(0xFED2161D),
    300: Color(0xFED2161D),
    400: Color(0xFED2161D),
    500: Color(0xFED2161D),
    600: Color(0xFED2161D),
    700: Color(0xFED2161D),
    800: Color(0xFED2161D),
    900: Color(0xFED2161D),
  }),
  scaffoldBackgroundColor: const Color(0xFfEFF0F1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFED2161D)),
    titleTextStyle: TextStyle(color: Color(0xFED2161D), fontSize: 20, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFED2161D),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFfFFCC01),
    onSecondary: Color(0xFF000000),
    primaryContainer: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF000000),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFED2161D),
      foregroundColor: const Color(0xFFFFFFFF),
      disabledBackgroundColor: const Color(0xFFBDBDBD),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFED2161D)),
    displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFED2161D)),
    displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFED2161D)),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF000000)),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF000000)),
    bodySmall: TextStyle(fontSize: 12, color: Color(0xFF000000)),
  ),
);
