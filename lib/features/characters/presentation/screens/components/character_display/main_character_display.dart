import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/ability_score_row.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/equipment_card.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/features_list.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/proficiencies_card.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/racial_trait_card.dart';
import 'package:mythos_manager/shared/extensions/capitalize.dart';

class MainCharacterDisplay extends ConsumerWidget {
  final Character character;

  const MainCharacterDisplay({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              character.className!,
              style: const TextStyle(fontSize: 20),
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "${character.race!.capitalize()}, ${character.subrace != null ? "${character.subrace!.capitalize()}, " : ""}${character.size}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            AbilityScoreRow(
                abilityScores: character.abilityScores!,
                abilityScoreIncreases: character.abilityScoreIncreases!,
                savingThrows: character.savingThrows!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text("Hit Die"),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(2.5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF90714A),
                      ),
                      child: Center(
                          child: Text(
                        "d${character.hitDie}",
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Speed"),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(2.5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF90714A),
                      ),
                      child: Center(
                          child: Text(
                        "${character.speed} ft.",
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            ProficienciesCard(
              skillProficiencies: character.skillProficiencies,
              equipmentProficiencies: character.equipmentProficiencies,
            ),
            EquipmentCard(equipment: character.equipment),
            RacialTraitCard(racialTraits: character.racialTraits),
            FeaturesList(
              className: character.className!,
              subclass: character.subclass!,
            ),
          ],
        ),
      ),
    );
  }
}
