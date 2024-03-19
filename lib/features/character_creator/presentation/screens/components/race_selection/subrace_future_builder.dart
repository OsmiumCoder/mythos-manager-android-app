import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';


/// Author: Jonathon Meney, Liam Welsh
class SubraceFutureBuilder extends HookConsumerWidget {
  const SubraceFutureBuilder({
    super.key,
    required this.subraceController,
    required this.textStyle,
  });

  final TextEditingController subraceController;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getSubrace(subraceController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final subrace = snapshot.data!;

            final String abilityBonuses =
            subrace["ability_bonuses"].map((element) {
              characterBuilder.state.raceAbilityScores[
              element["ability_score"]["name"]] = element["bonus"];
              return "+${element["bonus"]} ${element["ability_score"]["name"]}";
            }).join(", ");

            final String startingProficiencies =
            subrace["starting_proficiencies"].map((element) {
              if ((element["name"] as String).toLowerCase().contains("skill")) {
                characterBuilder.state.raceSkillProfs.add(element);
              } else {
                characterBuilder.state.raceEquipmentProfs.add(element);
              }
              return "${element["name"]}";
            }).join(", ");

            final String languages = subrace["languages"].map((element) {
              characterBuilder.state.raceLanguages.add(element);
              return "${element["name"]}";
            }).join(", ");

            final String racialTraits = subrace["traits"].map((element) {
              characterBuilder.state.racialTraits?.add(element);
              return "${element["name"]}";
            }).join(", ");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Ability Score Increases: $abilityBonuses",
                    style: textStyle,
                  ),
                ),
                startingProficiencies.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Starting Proficiencies: $startingProficiencies",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),
                languages.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Languages: $languages",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Traits: $racialTraits",
                    style: textStyle,
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
