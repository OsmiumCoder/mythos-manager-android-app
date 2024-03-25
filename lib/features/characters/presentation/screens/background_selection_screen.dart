import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/components.dart';

/// Author: Liam Welsh
class BackgroundSelectionScreen extends HookConsumerWidget {
  const BackgroundSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final backgroundController = useTextEditingController();

    useListenable(backgroundController);

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Character Creator"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: ref.watch(dndApiController).getAllBackgrounds(),
              builder: (context, snapshot) {
                final List<dynamic> backgrounds =
                    snapshot.data?["results"] ?? [];

                return backgrounds.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Column(
                            children: [
                              const Text("Choose a Background"),
                              DropdownMenu(
                                  controller: backgroundController,
                                  onSelected: (background) {
                                    characterBuilder.state.background =
                                        background;
                                    characterBuilder.state.backgroundLanguages
                                        .clear();
                                    characterBuilder.state.backgroundSkillProfs
                                        .clear();
                                    characterBuilder
                                        .state.backgroundEquipmentProfs
                                        .clear();
                                    characterBuilder.state.backgroundEquipment
                                        .clear();
                                  },
                                  width: 200,
                                  hintText: "Background",
                                  dropdownMenuEntries: backgrounds
                                      .map((background) => DropdownMenuEntry(
                                          value: background["name"],
                                          label: background["name"]))
                                      .toList()),
                              if (backgroundController.text.isNotEmpty)
                                BackgroundFutureBuilder(
                                    backgroundController: backgroundController),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
        ));
  }
}
