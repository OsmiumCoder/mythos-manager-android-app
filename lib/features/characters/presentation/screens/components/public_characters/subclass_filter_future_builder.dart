import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';

/// Author: Liam Welsh
///
/// [FutureBuilder] that returns a [DropDownMenu] of subclasses for public [Character] filtering
class SubclassFilterFutureBuilder extends HookConsumerWidget {
  final String selectedClass;
  final TextEditingController subclassController;

  const SubclassFilterFutureBuilder(
      {super.key,
      required this.selectedClass,
      required this.subclassController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.watch(dndApiController).getClass(selectedClass),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List subclasses = snapshot.data?["subclasses"];
            return DropdownMenu(
                controller: subclassController,
                dropdownMenuEntries: subclasses
                    .map((subclass) => DropdownMenuEntry(
                        value: subclass["name"], label: subclass["name"]))
                    .toList());
          }
          return const CircularProgressIndicator();
        });
  }
}
