import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/background_selection/background_future_builder.dart';

/// Author: Liam Welsh
class BackgroundSelectionScreen extends HookConsumerWidget {
  const BackgroundSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final backgroundController = useTextEditingController();

    useListenable(backgroundController);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Creator"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ref.watch(dndApiController).getAllBackgrounds(),
          builder: (context, snapshot) {
            final List<dynamic> backgrounds =
                snapshot.data?["results"] ?? [];

            return SingleChildScrollView(
                child: backgrounds.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                          child: Column(
                            children: [
                              const Text("Choose a Background"),
                              DropdownMenu(
                                  controller: backgroundController,
                                  width: 200,
                                  hintText: "Background",
                                  dropdownMenuEntries: backgrounds
                                      .map((background) => DropdownMenuEntry(
                                          value: background["index"],
                                          label: background["name"]))
                                      .toList()),
                              if (backgroundController.text.isNotEmpty)
                                BackgroundFutureBuilder(backgroundController: backgroundController),
                            ],
                          ),
                        ),
                    )
                    : const Center(child: Text("No Backgrounds Found")));
          }),
    );
  }
}
