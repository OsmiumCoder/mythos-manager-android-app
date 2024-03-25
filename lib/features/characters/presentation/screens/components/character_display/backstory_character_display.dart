import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

class BackstoryDisplay extends HookConsumerWidget {
  final Character character;

  const BackstoryDisplay({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    Widget buildCard(String title, String content) {
      return Card(
        color: theme.cardTheme.color,
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              Divider(color: Colors.white),
              Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            character.name ?? "Character Name",
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Text(
            character.alignment ?? "Alignment",
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          buildCard(
            'Character Details',
            'Age: ${character.age ?? "Unknown"}\n'
                'Weight: ${character.weight ?? "Unknown"}\n'
                'Height: ${character.height ?? "Unknown"}',
          ),
          buildCard(
            'Background',
            'Feature Name: ${character.backgroundFeatureName ?? "None"}\n'
                'Feature Description: ${character.backgroundFeatureDesc ?? "No description provided"}',
          ),
          buildCard(
            'Languages',
            character.languages?.join(", ") ?? "No languages provided",
          ),
          buildCard(
            'Backstory',
            character.backstory ?? "No backstory provided",
          ),
        ],
      ),
    );
  }
}
