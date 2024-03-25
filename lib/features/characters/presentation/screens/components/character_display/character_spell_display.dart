import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/spell_card.dart';

/// Author: Jonathon Meney
class CharacterSpellDisplay extends ConsumerWidget {
  final String className;

  const CharacterSpellDisplay({super.key, required this.className});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
              future: ref
                  .watch(dndApiController)
                  .getSpellsForClass(className.toLowerCase()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  List spells = snapshot.data!;

                  if (spells.isEmpty) {
                    return Center(
                        child: Text(
                      "$className has no spells available.",
                      style: const TextStyle(fontSize: 16),
                    ));
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: spells.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> spell = spells[index];
                      return SpellCard(spell: spell);
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const CircularProgressIndicator()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
