import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/components.dart';

/// Author: Jonathon Meney, Liam Welsh
class RaceFutureBuilder extends HookConsumerWidget {
  const RaceFutureBuilder({
    super.key,
    required this.raceController,
    required this.textStyle,
    required this.subraceController,
    required this.startingLanguageController,
    required this.abilityIncreaseController,
    required this.startingProficiencyController,
  });

  final TextEditingController raceController;
  final TextStyle textStyle;
  final TextEditingController subraceController;
  final TextEditingController startingLanguageController;
  final TextEditingController abilityIncreaseController;
  final TextEditingController startingProficiencyController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterBuilder = ref.read(characterBuilderProvider.notifier);
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getRace(raceController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final race = snapshot.data!;

            final String abilityBonuses =
                race["ability_bonuses"].map((element) {
              characterBuilder.state.raceAbilityScores[
                  element["ability_score"]["name"]] = element["bonus"];
              return "+${element["bonus"]} ${element["ability_score"]["name"]}";
            }).join(", ");

            final List abilityBonusOptions =
                race["ability_bonus_options"]?["from"]["options"] ?? [];

            final String languages = race["languages"].map((element) {
              characterBuilder.state.raceLanguages.add(element["name"]);
              return "${element["name"]}";
            }).join(", ");

            final List languageOptions =
                race["language_options"]?["from"]["options"] ?? [];

            final String traits = race["traits"].map((element) {
              characterBuilder.state.racialTraits.add(element["name"]);
              return "${element["name"]}";
            }).join(", ");

            final String startingProficiencies =
                race["starting_proficiencies"].map((element) {
                  if ((element["name"] as String).toLowerCase().contains("skill")) {
                    characterBuilder.state.raceSkillProfs.add(element["name"]);
                  } else {
                    characterBuilder.state.raceEquipmentProfs.add(element["name"]);
                  }
              return "${element["name"]}";
            }).join(", ");

            final List startingProficienciesOptions =
                race["starting_proficiency_options"]?["from"]["options"] ?? [];

            final List subraces = race["subraces"];

            characterBuilder.state.size = race["size"];
            characterBuilder.state.speed = race["speed"];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Race Selection.
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Size: ${race["size"]}",
                    style: textStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Languages: $languages",
                    style: textStyle,
                  ),
                ),

                languageOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose a Starting Language",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),

                languageOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: DropdownMenu(
                            controller: startingLanguageController,
                            onSelected: (lang) {
                              if (lang != null) {
                                characterBuilder.state.raceLanguages.add(lang);
                              }
                            },
                            dropdownMenuEntries: languageOptions.map((option) {
                              return DropdownMenuEntry(
                                  value: "${option["item"]["name"]}",
                                  label: "${option["item"]["name"]}");
                            }).toList()),
                      )
                    : const SizedBox.shrink(),

                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Speed: ${race["speed"]}",
                    style: textStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Ability Score Increases: $abilityBonuses",
                    style: textStyle,
                  ),
                ),

                abilityBonusOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose an Ability Score Increase",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),

                abilityBonusOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: DropdownMenu(
                            controller: abilityIncreaseController,
                            onSelected: (ability) {
                              if (ability != null) {
                                final ability =
                                    abilityIncreaseController.text.split(" ");
                                final value = ability[0][1];
                                final name = ability[1];
                                characterBuilder
                                        .state.raceAbilityScores[name] =
                                    int.parse(value);
                              }
                            },
                            dropdownMenuEntries:
                                abilityBonusOptions.map((option) {
                              return DropdownMenuEntry(
                                  value:
                                      "${option["bonus"]} ${option["ability_score"]["name"]}",
                                  label:
                                      "+${option["bonus"]} ${option["ability_score"]["name"]}");
                            }).toList()),
                      )
                    : const SizedBox.shrink(),

                traits.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Traits: $traits",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),

                startingProficiencies.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Starting Proficiencies: $startingProficiencies",
                          style: textStyle,
                        ))
                    : const SizedBox.shrink(),

                startingProficienciesOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose a Starting Proficiency",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),

                startingProficienciesOptions.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DropdownMenu(
                            onSelected: (element) {
                              if ((element as String).toLowerCase().contains("skill")) {
                                characterBuilder.state.raceSkillProfs.add(element);
                              } else {
                                characterBuilder.state.raceEquipmentProfs.add(element);
                              }
                            },
                            dropdownMenuEntries:
                                startingProficienciesOptions.map((option) {
                          return DropdownMenuEntry(
                              value: option["item"]["name"],
                              label: option["item"]["name"]);
                        }).toList()),
                      )
                    : const SizedBox.shrink(),

                subraces.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose a Subrace",
                          style: textStyle,
                        ),
                      )
                    : const SizedBox.shrink(),

                subraces.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DropdownMenu(
                            onSelected: (selected) =>
                                characterBuilder.state.subrace = selected,
                            dropdownMenuEntries: subraces.map((subrace) {
                              return DropdownMenuEntry(
                                  value: subrace["index"],
                                  label: subrace["name"]);
                            }).toList()),
                      )
                    : const SizedBox.shrink(),

                // Subrace selection.
                subraceController.text.isNotEmpty
                    ? SubraceFutureBuilder(
                        subraceController: subraceController,
                        textStyle: textStyle)
                    : const SizedBox.shrink(),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
