import 'package:flutter/material.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/routing/app_router.dart';

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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.characterDisplayScreen,
                      arguments: character);
                },
                child: Card(
                  child: SizedBox(
                    height: 100,
                    width: 300,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                character.name ??
                                    "Character #${characters.indexOf(character) + 1}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              if (character.className != null)
                                Text(
                                  character.className as String,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 20),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
