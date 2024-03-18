import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

///Author: Shreif Abdalla, Liam Welsh
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
    final selectedProficiency1 = useState<String?>(null);
    final selectedProficiency2 = useState<String?>(null);

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);

    return FutureBuilder(
      future: ref
          .watch(dndApiController)
          .getClass(classController.text.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        }

        final gameClass = snapshot.data!;
        final String hitDie = "Hit Die: d${gameClass["hit_die"]}";

        characterBuilder.state.hitDie = gameClass["hit_die"];

        final List<dynamic> proficiencyData = gameClass["proficiencies"] ?? [];
        final List<String> proficiencies = [];

        for (var element in proficiencyData) {
          if (!element["index"].startsWith("saving-throw")) {
            proficiencies.add(element["name"]);

            if ((element["name"] as String).toLowerCase().contains("skill")) {
              characterBuilder.state.classSkillProfs.add(element["name"]);
            } else {
              characterBuilder.state.classEquipmentProfs.add(element["name"]);
            }
          }
        }

        final List<dynamic> savingThrowsData = gameClass["saving_throws"] ?? [];
        final String savingThrows = savingThrowsData.map((element) {
          characterBuilder.state.classSavingThrows.add(element["name"]);
          return element["name"];
        }).join(", ");

        final List<dynamic> proficiencyOptions =
            gameClass["proficiency_choices"]?.first["from"]["options"] ?? [];
        final List<DropdownMenuEntry<String>> proficiencyItems1 = [];
        final List<DropdownMenuEntry<String>> proficiencyItems2 = [];

        String startingEquipment = (gameClass["starting_equipment"] ?? [])
            .where((element) =>
                element != null &&
                element["equipment"] != null &&
                element["equipment"]["name"] != null)
            .map((element) {
          characterBuilder.state.classEquipment
              .add(element["equipment"]["name"]);
          return element["equipment"]["name"];
        }).join(", ");

        final List<dynamic> startingEquipmentOptions =
            gameClass["starting_equipment_options"] ?? [];

        for (var element in startingEquipmentOptions) {
          element["from"]["options"]?.forEach((element) {
            if (element["option_type"] == "counted_reference") {
              startingEquipment +=
                  ", ${element["count"]} ${element["of"]["name"]}";
            }
          });
        }

        for (var option in proficiencyOptions) {
          final String name = option["item"]["name"];
          if (name != selectedProficiency2.value) {
            proficiencyItems1.add(DropdownMenuEntry(value: name, label: name));
          }
          if (name != selectedProficiency1.value) {
            proficiencyItems2.add(DropdownMenuEntry(value: name, label: name));
          }
        }

        final List<dynamic> subclasses = gameClass["subclasses"] ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(hitDie, style: textStyle),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Proficiencies: ${proficiencies.join(", ")}",
                    style: textStyle),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Saving Throws: $savingThrows", style: textStyle),
              ),
              const Text("Choose Proficiencies"),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: DropdownMenu(
                  dropdownMenuEntries: proficiencyItems1,
                  onSelected: (newValue) {
                    // Remove old value if it exists
                    characterBuilder.state.classSkillProfs.remove(selectedProficiency1.value);
                    characterBuilder.state.classEquipmentProfs.remove(selectedProficiency1.value);

                    selectedProficiency1.value = newValue;
                    if (newValue!.toLowerCase().contains("skill")) {
                      characterBuilder.state.classSkillProfs.add(newValue);
                    } else {
                      characterBuilder.state.classEquipmentProfs.add(newValue);
                    }

                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: DropdownMenu(
                    dropdownMenuEntries: proficiencyItems2,
                    onSelected: (newValue) {
                      // Remove old value if it exists
                      characterBuilder.state.classSkillProfs.remove(selectedProficiency2.value);
                      characterBuilder.state.classEquipmentProfs.remove(selectedProficiency2.value);

                      selectedProficiency2.value = newValue;
                      if (newValue!.toLowerCase().contains("skill")) {
                        characterBuilder.state.classSkillProfs.add(newValue);
                      } else {
                        characterBuilder.state.classEquipmentProfs
                            .add(newValue);
                      }

                    }),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Starting Equipment: $startingEquipment",
                    style: textStyle),
              ),
              subclasses.isNotEmpty
                  ? const Text("Choose Subclass")
                  : const SizedBox.shrink(),
              subclasses.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: DropdownMenu(
                        controller: subclassController,
                        onSelected: (subclass) =>
                            characterBuilder.state.subclass = subclass,
                        dropdownMenuEntries: subclasses.map((element) {
                          return DropdownMenuEntry(
                              value: element["name"], label: element["name"]);
                        }).toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
