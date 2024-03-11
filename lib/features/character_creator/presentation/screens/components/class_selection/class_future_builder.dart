import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/class_selection/subclass_future_builder.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/components.dart';

class ClassFutureBuilder extends HookConsumerWidget {
  const ClassFutureBuilder({
    super.key,
    required this.classController,
    required this.textStyle,
    required this.subclassController,
    required this.hitDieController,
    required this.proficiencyController,
    required this.savingThrowsController,
    required this.startingEquipmentController,
  });

  final TextEditingController classController;
  final TextStyle textStyle;
  final TextEditingController subclassController;
  final TextEditingController hitDieController;
  final TextEditingController proficiencyController;
  final TextEditingController savingThrowsController;
  final TextEditingController startingEquipmentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(dndApiController).getClass(
          classController.text.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final gameClass = snapshot.data!;

          final String hitDie = "Hit Die: ${gameClass["hit_die"]}";

          final String proficiencies = gameClass["proficiencies"].map((element) {
            return "${element["name"]}";
          }).join(", ");

          final List proficiencyOptions = gameClass["proficiency_choices"] ?? [];

          final String savingThrows =
          gameClass["saving_throws"].map((element) {
            return "${element["name"]}";
          }).join(", ");

          final String startingEquipment =
          gameClass["starting_equipment"].map((element) {
            return "${element["equipment"]["name"]}";
          }).join(", ");

          final List startingEquipmentOptions =
              gameClass["starting_equipment_options"]?["from"]["options"] ??
                  [];

          final subclasses = gameClass["subclasses"];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  hitDie,
                  style: textStyle,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Proficiencies: $proficiencies",
                  style: textStyle,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Saving Throws: $savingThrows",
                  style: textStyle,
                ),
              ),
              if (subclasses is List) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Hit Die: $hitDie",
                        style: textStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Proficiencies: $proficiencies",
                        style: textStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Saving Throws: $savingThrows",
                        style: textStyle,
                      ),
                    ),
                    if (proficiencyOptions.isNotEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose a Proficiency",
                          style: textStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: DropdownMenu(
                          controller: proficiencyController,
                          dropdownMenuEntries: proficiencyOptions.map((option) {
                            return DropdownMenuEntry(
                              value: "${option["item"]["name"]}",
                              label: "${option["item"]["name"]}",
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    if (subclasses.isNotEmpty) ...[
                      SubclassFutureBuilder(
                        classController: classController,
                        subclassController: subclassController,
                        textStyle: textStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose a Subclass",
                          style: textStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: DropdownMenu(
                          controller: subclassController,
                          dropdownMenuEntries: subclasses.map((subclass) {
                            return DropdownMenuEntry(
                              value: "${subclass["index"]}",
                              label: "${subclass["name"]}",
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Saving Throws: $savingThrows",
                        style: textStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Starting Equipment: $startingEquipment",
                        style: textStyle,
                      ),
                    ),
                    if (startingEquipmentOptions.isNotEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Choose Starting Equipment",
                          style: textStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: DropdownMenu(
                          controller: startingEquipmentController,
                          dropdownMenuEntries: startingEquipmentOptions.map((
                              option) {
                            return DropdownMenuEntry(
                              value: "${option["item"]["name"]}",
                              label: "${option["item"]["name"]}",
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ] else
                Text(
                  "No subclasses available",
                  style: textStyle,
                ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
