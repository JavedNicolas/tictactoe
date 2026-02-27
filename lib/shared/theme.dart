import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/shared/constant.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(kMainColor.toARGB32(), <int, Color>{
    50: kMainColor,
    100: kMainColor,
    200: kMainColor,
    300: kMainColor,
    400: kMainColor,
    500: kMainColor,
    600: kMainColor,
    700: kMainColor,
    800: kMainColor,
    900: kMainColor,
  }),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    iconTheme: IconThemeData(color: kMainColor),
    titleTextStyle: TextStyle(color: kMainColor, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.light(
    primary: kMainColor,
    onPrimary: kOnMainColor,
    secondary: kSecondaryColor,
    onSecondary: kOnSecondaryColor,
    surfaceContainer: kContainerColor,
    surface: kBackgroundColor,
    onSurface: kMainTextColor,
    surfaceContainerHigh: kSurfaceContainerHigh,
    inverseSurface: Colors.black54,
    onInverseSurface: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kMainColor,
      foregroundColor: kOnMainColor,
      disabledBackgroundColor: kDisabledColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.rammettoOne(fontSize: 32, fontWeight: FontWeight.bold, color: kMainColor),
    displayMedium: GoogleFonts.rammettoOne(fontSize: 24, fontWeight: FontWeight.bold, color: kMainColor),
    displaySmall: GoogleFonts.rammettoOne(fontSize: 18, fontWeight: FontWeight.bold, color: kMainColor),
    titleLarge: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: kMainTextColor),
    titleMedium: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: kMainTextColor),
    titleSmall: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: kMainTextColor),
    bodyLarge: GoogleFonts.roboto(fontSize: 16, color: kMainTextColor),
    bodyMedium: GoogleFonts.roboto(fontSize: 14, color: kMainTextColor),
    bodySmall: GoogleFonts.roboto(fontSize: 12, color: kMainTextColor),
  ),
);
