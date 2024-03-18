import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

import '../../../../routing/app_router.dart';
import 'components/class_selection/class_future_builder.dart';

///Author: Shreif Abdalla, Liam Welsh
class ClassSelectionScreen extends HookConsumerWidget {
  const ClassSelectionScreen({super.key});

  final TextStyle textStyle = const TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classController = useTextEditingController();
    final subclassController = useTextEditingController();
    final hitDieController = useTextEditingController();
    final proficiencyController = useTextEditingController();
    final savingThrowsController = useTextEditingController();
    final startingEquipmentController = useTextEditingController();

    useListenable(classController);
    useListenable(subclassController);

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
                  child: Text("Choose a Class", style: TextStyle(fontSize: 20))),
              FutureBuilder(
                  future: ref.watch(dndApiController).getAllClasses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List allClasses = snapshot.data!["results"];
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: DropdownMenu(
                                onSelected: (selected) {
                                  characterBuilder.state.className = selected;

                                  subclassController.text = "";
                                  hitDieController.clear();
                                  proficiencyController.clear();
                                  savingThrowsController.clear();
                                  startingEquipmentController.clear();

                                  characterBuilder.state.subclass = null;
                                  characterBuilder.state.hitDie = null;
                                  characterBuilder.state.classSavingThrows.clear();
                                  characterBuilder.state.classEquipment.clear();
                                  characterBuilder.state.classSkillProfs.clear();
                                  characterBuilder.state.classEquipmentProfs.clear();

                                },
                                controller: classController,
                                dropdownMenuEntries: allClasses.map((classData) {
                                  return DropdownMenuEntry(
                                      value: classData["name"],
                                      label: classData["name"]);
                                }).toList()),
                          ),
                          classController.text.isNotEmpty
                              ? ClassFutureBuilder(
                            classController: classController,
                            textStyle: textStyle,
                            subclassController: subclassController,
                            hitDieController: hitDieController,
                            proficiencyController: proficiencyController,
                            savingThrowsController: savingThrowsController,
                            startingEquipmentController: startingEquipmentController,
                          )
                              : const SizedBox.shrink(),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  onPressed: () {
                    print(characterBuilder.state.toString());
                    Navigator.of(context).pushNamed(AppRouter.abilitySelectionScreen);
                  },
                  child: const Text('Select Class')),
            ],
          ),
        ),
      ),
    );
  }
}
