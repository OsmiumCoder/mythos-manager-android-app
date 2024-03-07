import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/components.dart';

class RaceFutureBuilder extends HookConsumerWidget {
  const RaceFutureBuilder({
    super.key,
    required this.raceController,
    required this.textStyle,
    required this.subraceController,
  });

  final TextEditingController raceController;
  final TextStyle textStyle;
  final TextEditingController subraceController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getRace(raceController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final race = snapshot.data!;
            final String abilityBonuses =
                race["ability_bonuses"].map((element) {
              return "+${element["bonus"]} ${element["ability_score"]["name"]}";
            }).join(", ");

            final String languages = race["languages"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String traits = race["traits"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String startingProficiencies =
                race["starting_proficiencies"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final List startingProficienciesOptions =
                race["starting_proficiency_options"]?["from"]["options"] ?? [];

            final List subraces = race["subraces"];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Race Selection.
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Alignment: ${race["Alignment"]}",
                    style: textStyle,
                  ),
                ),
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
                            dropdownMenuEntries:
                                startingProficienciesOptions.map((option) {
                          return DropdownMenuEntry(
                              value: option["item"]["index"],
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
                            onSelected: (selected) {
                              subraceController.text = selected;
                            },
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
