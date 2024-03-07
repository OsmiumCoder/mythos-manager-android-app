import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

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
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getSubrace(subraceController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final subrace = snapshot.data!;

            final String abilityBonuses =
                subrace["ability_bonuses"].map((element) {
              return "+${element["bonus"]} ${element["ability_score"]["name"]}";
            }).join(", ");

            final String startingProficiencies =
                subrace["starting_proficiencies"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String languages = subrace["languages"].map((element) {
              return "${element["name"]}";
            }).join(", ");

            final String racialTraits = subrace["racial_traits"].map((element) {
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
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Starting Proficiencies: $startingProficiencies",
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
