import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

import 'character_detail_card.dart';

/// Author: Shreif Abdalla
class BackstoryDisplay extends HookConsumerWidget {
  final Character character;

  const BackstoryDisplay({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
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
          CharacterDetailCard(
            title: 'Character Details',
            content: 'Age: ${character.age ?? "Unknown"}\n'
                'Weight: ${character.weight ?? "Unknown"}\n'
                'Height: ${character.height ?? "Unknown"}',
            theme: theme,
          ),
          CharacterDetailCard(
            title: 'Background',
            content: '${character.backgroundFeatureName ?? "None"}\n'
                '${character.backgroundFeatureDesc ?? "No description provided"}',
            theme: theme,
          ),
          CharacterDetailCard(
            title: 'Languages',
            content: character.languages?.join(", ") ?? "No languages provided",
            theme: theme,
          ),
          CharacterDetailCard(
            title: 'Backstory',
            content: character.backstory ?? "No backstory provided",
            theme: theme,
          ),
        ],
      ),
    );
  }
}
