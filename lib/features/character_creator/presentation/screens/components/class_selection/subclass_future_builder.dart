import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

class SubclassFutureBuilder extends HookConsumerWidget {
  const SubclassFutureBuilder({
    super.key,
    required this.classController,
    required this.subclassController,
    required this.textStyle,
  });

  final TextEditingController classController;
  final TextStyle textStyle;
  final TextEditingController subclassController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getSubclass(subclassController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final subclass = snapshot.data!;

            final String abilityBonuses =
            subclass["ability_bonuses"].map((element) {
              return "+${element["bonus"]} ${element["ability_score"]["name"]}";
            }).join(", ");

            final String startingProficiencies =
            subclass["starting_proficiencies"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String languages = subclass["languages"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String racialTraits = subclass["racial_traits"].map((element) {
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
