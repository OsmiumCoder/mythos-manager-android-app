import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/themes/theme_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Author: Shreif Abdalla

const alignments = [
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

class BackstorySelectionScreen extends HookConsumerWidget {
  const BackstorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Character Creator'), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    hintText: 'Age',
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
                    hintText: 'Weight',
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
                    hintText: 'Height',
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
                  onPressed: () {}, //TODO Add Navigation
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}