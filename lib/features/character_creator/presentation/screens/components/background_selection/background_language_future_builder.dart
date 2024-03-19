import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

/// Author: Liam Welsh
class BackgroundLanguageFutureBuilder extends HookConsumerWidget {
  final List<TextEditingController> textEditingControllers;
  const BackgroundLanguageFutureBuilder(
      {super.key, required this.textEditingControllers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var controller in textEditingControllers) {
      useListenable(controller);
    }

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return FutureBuilder(
        future: ref.watch(dndApiController).getAllLanguages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final languages = snapshot.data!["results"] as List;

            final filteredLanguages = languages
                .where((language) => !textEditingControllers
                    .map((c) => c.text.toLowerCase())
                    .contains('${language["name"]}'.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  const Text("Language Options"),
                  for (var i = 0; i < textEditingControllers.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DropdownMenu(
                        width: 200,
                        hintText: "Select Language",
                        controller: textEditingControllers[i],
                        onSelected: (language) {
                          // Remove old languages
                          characterBuilder.state.backgroundLanguages
                              .removeWhere((element) =>
                                  element != language &&
                                  !textEditingControllers
                                      .map((e) => e.text)
                                      .contains(element));

                          characterBuilder.state.backgroundLanguages
                              .add(language);
                        },
                        dropdownMenuEntries: filteredLanguages
                            .map((language) => DropdownMenuEntry(
                                value: language["name"],
                                label: language["name"]))
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
