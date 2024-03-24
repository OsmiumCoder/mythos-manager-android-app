import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/public_characters/class_future_builder.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

import '../../../../routing/app_router.dart';

class PublicCharactersScreen extends HookConsumerWidget {
  const PublicCharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClass = useState<dynamic>(null);
    final classController = useTextEditingController();
    final subclassController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Public Characters"),
        centerTitle: true,
      ),
      drawer: const MythosDrawer(
        selectedScreen: AppRouter.publicCharactersScreen,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Filters", style: TextStyle(fontSize: 20),),
          ),
          FutureBuilder(
              future: ref.watch(dndApiController).getAllClasses(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List classes = snapshot.data?["results"];
                  return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownMenu(
                              controller: classController,
                              onSelected: (val) => selectedClass.value = val,
                              dropdownMenuEntries: classes
                                  .map((c) =>
                                      DropdownMenuEntry(value: c, label: c["name"]))
                                  .toList()),
                          if (selectedClass.value != null)
                            ClassFutureBuilder(
                                selectedClass: selectedClass.value["index"],
                                subclassController: subclassController)
                        ],
                      );
                }
                return const SizedBox.shrink();
              }),
          // FutureBuilder(future: ref.watch(characterControllerProvider.notifier)., builder: builder)
        ],
      ),
    );
  }
}
