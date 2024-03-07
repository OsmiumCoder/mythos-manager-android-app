import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/components.dart';

class RaceSelectionScreen extends HookConsumerWidget {
  const RaceSelectionScreen({super.key});

  final TextStyle textStyle = const TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raceController = useTextEditingController();
    final subraceController = useTextEditingController();
    useListenable(raceController);
    useListenable(subraceController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Creator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Text("Choose a Race", style: TextStyle(fontSize: 20))),
              FutureBuilder(
                  future: ref.watch(dndApiController).getAllRaces(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List allRaces = snapshot.data!["results"];
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: DropdownMenu(
                                onSelected: (selected) {
                                  subraceController.clear();
                                },
                                controller: raceController,
                                dropdownMenuEntries: allRaces.map((race) {
                                  return DropdownMenuEntry(
                                      value: race["index"],
                                      label: race["name"]);
                                }).toList()),
                          ),
                          raceController.text.isNotEmpty
                              ? RaceFutureBuilder(
                                  raceController: raceController,
                                  textStyle: textStyle,
                                  subraceController: subraceController)
                              : const SizedBox.shrink(),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  onPressed: () {
                    // TODO: route to next
                    // TODO: validate
                    // TODO: push to saving map
                  },
                  child: const Text("Select Race")),
            ],
          ),
        ),
      ),
    );
  }
}
