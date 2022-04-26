import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlueAccent.shade100),
    backgroundColor: Colors.white,
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
  );
}
