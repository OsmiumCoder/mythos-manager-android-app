import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';

import 'components/class_selection/class_future_builder.dart';

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
                                  subclassController.text = "";
                                  hitDieController.clear();
                                  proficiencyController.clear();
                                  savingThrowsController.clear();
                                  startingEquipmentController.clear();
                                },
                                controller: classController,
                                dropdownMenuEntries: allClasses.map((classData) {
                                  return DropdownMenuEntry(
                                      value: classData["index"],
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
                    print(classController.text);
                    print(subclassController.text);
                    print(hitDieController.text);
                    print(proficiencyController.text);
                    print(savingThrowsController.text);
                    print(startingEquipmentController.text);
                  },
                  child: const Text('Select Class')),
            ],
          ),
        ),
      ),
    );
  }
}
