import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Authors: Liam Welsh, Jonathon Meney, Sherif Abdalla
final themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC7AA87)),
    primaryColor: const Color(0xFFC7AA87),
    fontFamily: GoogleFonts.openSans().fontFamily,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF90714A),
        titleTextStyle:
            GoogleFonts.openSans(fontSize: 25, color: Colors.black)),
    scaffoldBackgroundColor: const Color(0xFFC7AA87),
    textTheme: Typography().black,
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
    ),
    dialogTheme: const DialogTheme(backgroundColor: Color(0xFFC7AA87)),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: Color(0xFF90714A),
        constraints: BoxConstraints(maxHeight: 40),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color(0xFF90714A),
          ),
          padding:
              MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
          maximumSize: MaterialStateProperty.resolveWith(
              (states) => const Size(double.infinity, 200))),
    ),
    cardTheme: const CardTheme(color: Color(0xFF90714A)));
