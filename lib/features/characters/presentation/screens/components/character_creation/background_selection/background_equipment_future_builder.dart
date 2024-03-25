import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';

/// Author: Liam Welsh
class BackgroundEquipmentFutureBuilder extends HookConsumerWidget {
  final String category;
  final List<TextEditingController> textEditingControllers;
  final List<dynamic> startingEquipment;

  const BackgroundEquipmentFutureBuilder(
      {super.key,
      required this.textEditingControllers,
      required this.category,
      required this.startingEquipment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var controller in textEditingControllers) {
      useListenable(controller);
    }
    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return FutureBuilder(
        future: ref.watch(dndApiController).getEquipment(category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final equipment = snapshot.data!["equipment"] as List;

            final filteredEquipment = equipment
                .where((eq) => !textEditingControllers
                    .map((c) => c.text.toLowerCase())
                    .contains('${eq["name"]}'.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  const Text("Equipment Options"),
                  for (var i = 0; i < textEditingControllers.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DropdownMenu(
                        width: 200,
                        hintText: "Select Equipment",
                        controller: textEditingControllers[i],
                        onSelected: (eq) {
                          // Remove old equipment
                          characterBuilder.state.backgroundEquipment
                              .removeWhere((element) =>
                                  element != eq &&
                                  !startingEquipment.contains(element) &&
                                  !textEditingControllers
                                      .map((e) => e.text)
                                      .contains(element));

                          characterBuilder.state.backgroundEquipment.add(eq);
                        },
                        dropdownMenuEntries: filteredEquipment
                            .map((eq) => DropdownMenuEntry(
                                value: eq["name"], label: eq["name"]))
                            .toList(),
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
