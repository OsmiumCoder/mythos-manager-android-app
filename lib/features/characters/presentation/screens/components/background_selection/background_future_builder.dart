import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/components.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Liam Welsh
class BackgroundFutureBuilder extends HookConsumerWidget {
  final TextEditingController backgroundController;

  const BackgroundFutureBuilder(
      {super.key, required this.backgroundController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getBackground(backgroundController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final proficiencies = snapshot.data!["starting_proficiencies"];

            final proficienciesText = proficiencies
                .map((proficiency) {
                  if ((proficiency["name"] as String).toLowerCase() == "skill") {
                    characterBuilder.state.backgroundSkillProfs.add(proficiency["name"]);
                  } else {
                    characterBuilder.state.backgroundEquipmentProfs.add(proficiency["name"]);
                  }
              return proficiency["name"];
            }).join(", ");

            final startingEquipment = snapshot.data!["starting_equipment"];

            final startingEquipmentText = startingEquipment
                .map((equipment) {
                  characterBuilder.state.backgroundEquipment.add(equipment["equipment"]["name"]);
              return equipment["equipment"]["name"];
            })
                .join("; ");

            final numberOfLanguages =
                snapshot.data!["language_options"]["choose"];

            final languageTextControllers = <TextEditingController>[];

            for (var i = 0; i < numberOfLanguages; i++) {
              languageTextControllers.add(TextEditingController());
            }

            final numberOfEquipment =
                snapshot.data!["starting_equipment_options"][0]["choose"];

            final equipmentTextControllers = <TextEditingController>[];

            for (var i = 0; i < numberOfEquipment; i++) {
              equipmentTextControllers.add(TextEditingController());
            }

            final equipmentType = snapshot.data!["starting_equipment_options"]
                [0]["from"]["equipment_category"]["index"];

            final String featureText = snapshot.data!["feature"]["desc"]?[0] ?? "";

            characterBuilder.state.backgroundFeatureDesc = featureText;
            characterBuilder.state.backgroundFeatureName = snapshot.data!["feature"]["name"];

            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    Text(
                      "Proficiencies: $proficienciesText",
                      style: const TextStyle(fontSize: 16),
                    ),
                    BackgroundLanguageFutureBuilder(
                        textEditingControllers: languageTextControllers),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Starting Equipment: $startingEquipmentText",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    BackgroundEquipmentFutureBuilder(
                      textEditingControllers: equipmentTextControllers,
                      category: equipmentType,
                      startingEquipment: startingEquipment.map((eq) => eq["equipment"]["name"]).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(featureText, style: const TextStyle(fontSize: 16),),
                    ),

                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.backstorySelectionScreen);
                        },
                        child: const Text("Save Background")),
                  ],
                ),
              );
          } else {
            return const Padding(
              padding: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
