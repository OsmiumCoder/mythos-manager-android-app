import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routing/app_router.dart';

/// Author: Shreif Abdalla
class BackStoryScreen extends StatelessWidget {
  const BackStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Backstory Selection')),
        body: const BackStoryForm(),
      ),
    );
  }
}

class BackStoryForm extends StatefulWidget {
  const BackStoryForm({super.key});

  @override
  _BackStoryForm createState() => _BackStoryForm();
}

class _BackStoryForm extends State<BackStoryForm> {
  final alignments = [
    "Lawful good",
    'Neutral Good',
    'Chaotic Good',
    'Lawful Neutral',
    'True Neutral',
    'Chaotic Neutral',
    'Lawful Evil',
    'Neutral Evil',
    'Chaotic Evil'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text('Alignment',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 20),
            DropdownMenu(
                dropdownMenuEntries: alignments.map((element) {
              return DropdownMenuEntry(value: element, label: element);
            }).toList()),
            const SizedBox(height: 20),
            const Text('Enter the age of your character',
                style: TextStyle(color: Colors.black)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Please enter',
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text('Enter the weight of your character',
                style: TextStyle(color: Colors.black)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Please enter',
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text('Enter the height of your character',
                style: TextStyle(color: Colors.black)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Please enter',
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text('Enter the backstory of your character',
                style: TextStyle(color: Colors.black)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Please enter',
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
              ),
              style: const TextStyle(color: Colors.black),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRouter.backgroundSelectionScreen);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

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
        borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF90714A), width: 2)),
  ),
  dialogTheme: const DialogTheme(backgroundColor: Color(0xFFC7AA87)),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: const TextStyle(),
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
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
        maximumSize: MaterialStateProperty.resolveWith(
            (states) => const Size(200, 200))),
  ),
);
