import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

/// Author: Liam Welsh
class BackgroundSelectionScreen extends HookConsumerWidget {
  const BackgroundSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Creator"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ref.watch(dndApiController).getAllBackgrounds(),
          builder: (context, snapshot) {
            print(snapshot.data);

            final List<dynamic> backgrounds =
                snapshot.data?["results"] ?? [];

            return SingleChildScrollView(
                child: backgrounds.isNotEmpty
                    ? Center(
                        child: Column(
                          children: [
                            const Text("Choose a Background"),
                            DropdownMenu(
                                hintText: "Background",
                                dropdownMenuEntries: backgrounds
                                    .map((background) => DropdownMenuEntry(
                                        value: background["index"],
                                        label: background["name"]))
                                    .toList()),
                          ],
                        ),
                      )
                    : const Center(child: Text("No Backgrounds Found")));
          }),
    );
  }
}
