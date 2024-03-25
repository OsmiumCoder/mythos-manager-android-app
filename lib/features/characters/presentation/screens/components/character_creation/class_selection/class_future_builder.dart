import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';

///Author: Shreif Abdalla, Liam Welsh
class ClassFutureBuilder extends HookConsumerWidget {
  const ClassFutureBuilder({
    super.key,
    required this.classController,
    required this.textStyle,
    required this.subclassController,
    required this.hitDieController,
    required this.selectedProficiency1Controller,
    required this.selectedProficiency2Controller,
    required this.savingThrowsController,
    required this.startingEquipmentController,
  });

  final TextEditingController classController;
  final TextStyle textStyle;
  final TextEditingController subclassController;
  final TextEditingController hitDieController;
  final TextEditingController selectedProficiency1Controller;
  final TextEditingController selectedProficiency2Controller;

  final TextEditingController savingThrowsController;
  final TextEditingController startingEquipmentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterBuilder = ref.watch(characterBuilderProvider.notifier);

    useListenable(selectedProficiency1Controller);
    useListenable(selectedProficiency2Controller);

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

        final proficiencyItems1 = proficiencyOptions
            .where((element) => element != selectedProficiency2Controller.text)
            .map((e) => DropdownMenuEntry(
                value: e["item"]["name"], label: e["item"]["name"]))
            .toList();

        final proficiencyItems2 = proficiencyOptions
            .where((element) =>
                element["item"]["name"].toString().toLowerCase() !=
                selectedProficiency1Controller.text.toLowerCase())
            .map((e) => DropdownMenuEntry(
                value: e["item"]["name"], label: e["item"]["name"]))
            .toList();

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
                  controller: selectedProficiency1Controller,
                  dropdownMenuEntries: proficiencyItems1,
                  onSelected: (newValue) {
                    // Remove any old values
                    characterBuilder.state.classSkillProfs.removeWhere(
                        (element) =>
                            element != newValue &&
                            element != selectedProficiency2Controller.text &&
                            !proficiencyData
                                .map((e) => e["name"])
                                .contains(element));

                    characterBuilder.state.classEquipmentProfs.removeWhere(
                        (element) =>
                            element != newValue &&
                            element != selectedProficiency1Controller.text &&
                            !proficiencyData
                                .map((e) => e["name"])
                                .contains(element));

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
                    controller: selectedProficiency2Controller,
                    dropdownMenuEntries: proficiencyItems2,
                    onSelected: (newValue) {
                      // Remove any old values
                      characterBuilder.state.classSkillProfs.removeWhere(
                          (element) =>
                              element != newValue &&
                              element != selectedProficiency1Controller.text &&
                              !proficiencyData
                                  .map((e) => e["name"])
                                  .contains(element));

                      characterBuilder.state.classEquipmentProfs.removeWhere(
                          (element) =>
                              element != newValue &&
                              element != selectedProficiency1Controller.text &&
                              !proficiencyData
                                  .map((e) => e["name"])
                                  .contains(element));

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
