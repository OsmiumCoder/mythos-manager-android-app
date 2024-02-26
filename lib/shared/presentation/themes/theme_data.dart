import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC7AA87)),
  primaryColor: const Color(0xFFC7AA87),
  fontFamily: GoogleFonts.openSans().fontFamily,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF90714A),
      titleTextStyle: GoogleFonts.openSans(fontSize: 25, color: Colors.black)),
  scaffoldBackgroundColor: const Color(0xFFC7AA87),
  textTheme: Typography().white,
  inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2))),
);
