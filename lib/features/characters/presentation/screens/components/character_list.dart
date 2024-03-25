import 'package:flutter/material.dart';

import '../../../../../routing/app_router.dart';
import '../../../../../shared/presentation/components/box_shadow_image.dart';
import '../../../domain/character.dart';

/// Author: Liam Welsh
class CharacterList extends StatelessWidget {
  final List<Character> characters;
  const CharacterList({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...characters.map((Character character) => Padding(
          padding: const EdgeInsets.all(16),
          child: BoxShadowImage(
            text: Text(
              character.name ??
                  "Character #${characters.indexOf(character)}",
              style: const TextStyle(color: Colors.white),
            ),
            height: 100,
            width: 300,
            textPadding: 25,
            onTap: () {
              Navigator.pushNamed(
                  context, AppRouter.characterDisplayScreen,
                  arguments: character);
            },
          ),
        ))
      ],
    );
  }
}
