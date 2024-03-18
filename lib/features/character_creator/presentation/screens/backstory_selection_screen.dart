import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Author: Shreif Abdalla
class BackstorySelectionScreen extends HookConsumerWidget {
  const BackstorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alignmentController = useTextEditingController();
    final ageController = useTextEditingController();
    final weightController = useTextEditingController();
    final heightController = useTextEditingController();
    final backstoryController = useTextEditingController();
    final nameController = useTextEditingController();

    final List alignments = [
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

    return Scaffold(
      appBar: AppBar(title: const Text('Character Creator'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Text('Alignment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              DropdownMenu(
                  controller: alignmentController,
                  dropdownMenuEntries: alignments.map((element) {
                    return DropdownMenuEntry(value: element, label: element);
                  }).toList()),
              const SizedBox(height: 5),
              const Text('Enter the age of your character'),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 5),
              const Text('Enter the weight of your character'),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  hintText: 'Weight',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 5),
              const Text('Enter the height of your character'),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  hintText: 'Height',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 5),
              const Text('Enter the backstory of your character'),
              TextField(
                controller: backstoryController,
                decoration: InputDecoration(
                  hintText: 'Please enter',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 5),
              const Text('Enter the name of your character'),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Please enter',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  print(alignmentController.text);
                  print(ageController.text);
                  print(weightController.text);
                  print(heightController.text);
                  print(backstoryController.text);
                  print(nameController.text);
                  // TODO Add Navigation
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
