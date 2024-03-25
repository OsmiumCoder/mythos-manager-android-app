import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/components.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Jonathon Meney, Liam Welsh
class RaceSelectionScreen extends HookConsumerWidget {
  const RaceSelectionScreen({super.key});

  final TextStyle textStyle = const TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raceController = useTextEditingController();
    final subraceController = useTextEditingController();
    final startingLanguageController = useTextEditingController();
    final abilityIncreaseController = useTextEditingController();
    final startingProficiencyController = useTextEditingController();

    useListenable(raceController);
    useListenable(subraceController);

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
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
                                onSelected: (race) {
                                  subraceController.clear();
                                  startingProficiencyController.clear();
                                  abilityIncreaseController.clear();
                                  startingLanguageController.clear();

                                  characterBuilder.state.raceLanguages.clear();
                                  characterBuilder.state.raceEquipmentProfs
                                      .clear();
                                  characterBuilder.state.raceSkillProfs.clear();
                                  characterBuilder.state.raceAbilityScores
                                      .clear();

                                  characterBuilder.state.race = race;
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
                                  subraceController: subraceController,
                                  startingLanguageController:
                                      startingLanguageController,
                                  abilityIncreaseController:
                                      abilityIncreaseController,
                                  startingProficiencyController:
                                      startingProficiencyController,
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  onPressed: raceController.text.isNotEmpty
                      ? () => Navigator.pushNamed(
                          context, AppRouter.classSelectionScreen)
                      : null,
                  child: const Text("Select Race")),
            ],
          ),
        ),
      ),
    );
  }
}
