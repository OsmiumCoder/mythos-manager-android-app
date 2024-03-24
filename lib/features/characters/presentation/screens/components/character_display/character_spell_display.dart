import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';

class CharacterSpellDisplay extends ConsumerWidget {
  final String className;

  const CharacterSpellDisplay({super.key, required this.className});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(dndApiController).getSpellsForClass(className),
      builder:
          (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        return const Text("data");
      },
    );
  }
}
