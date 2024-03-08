import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/background_selection/background_equipment_future_builder.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/background_selection/background_language_future_builder.dart';

class BackgroundFutureBuilder extends HookConsumerWidget {
  final TextEditingController backgroundController;

  const BackgroundFutureBuilder(
      {super.key, required this.backgroundController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .watch(dndApiController)
            .getBackground(backgroundController.text.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final proficiencies = snapshot.data!["starting_proficiencies"];

            final proficienciesText = proficiencies
                .map((proficiency) => proficiency["name"])
                .join(", ");

            final startingEquipment = snapshot.data!["starting_equipment"];

            final startingEquipmentText = startingEquipment
                .map((equipment) => equipment["equipment"]["name"])
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(featureText, style: const TextStyle(fontSize: 16),),
                    ),

                    ElevatedButton(
                        onPressed: () {
                          print(backgroundController.text);

                          for (var controller in languageTextControllers) {
                            print(controller.text);
                          }

                          for (var controller in equipmentTextControllers) {
                            print(controller.text);
                          }

                          // TODO: route to next
                          // TODO: validate
                          // TODO: push to saving map
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
