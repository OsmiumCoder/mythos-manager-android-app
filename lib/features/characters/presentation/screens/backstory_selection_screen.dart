import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Shreif Abdalla, Liam Welsh
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

    const List alignments = [
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

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
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
                  onSelected: (alignment) =>
                      characterBuilder.state.alignment = alignment,
                  dropdownMenuEntries: alignments.map((element) {
                    return DropdownMenuEntry(value: element, label: element);
                  }).toList()),
              const SizedBox(height: 5),
              const Text('Enter the age of your character'),
              TextField(
                controller: ageController,
                onChanged: (age) =>
                    age.isNotEmpty ? characterBuilder.state.age = age : null,
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
                onChanged: (weight) => weight.isNotEmpty
                    ? characterBuilder.state.weight = weight
                    : null,
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
                onChanged: (height) => height.isNotEmpty
                    ? characterBuilder.state.height = height
                    : null,
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
                onChanged: (backStory) => backStory.isNotEmpty
                    ? characterBuilder.state.backstory = backStory
                    : null,
                decoration: InputDecoration(
                  hintText: 'Backstory',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 5),
              const Text('Enter the name of your character'),
              TextField(
                controller: nameController,
                onChanged: (name) =>
                    name.isNotEmpty ? characterBuilder.state.name = name : null,
                decoration: InputDecoration(
                  hintText: 'Name',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(characterControllerProvider.notifier)
                      .createCharacter(characterBuilder.state.toCharacter());

                  Navigator.pushReplacementNamed(
                      context, AppRouter.charactersScreen);
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
