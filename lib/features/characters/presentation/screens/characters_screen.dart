import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_list.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

/// Author: Liam Welsh
class CharactersScreen extends HookConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterController = ref.watch(characterControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        centerTitle: true,
      ),
      drawer: const MythosDrawer(
        selectedScreen: AppRouter.charactersScreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(35),
              child: BoxShadowImage(
                onTap: () {
                  // Reset character creation state
                  ref.read(characterBuilderProvider.notifier).state =
                      CharacterBuilderController();
                  Navigator.pushNamed(context, AppRouter.raceSelectionScreen);
                },
                image: Image.asset(
                  "assets/images/character_creator_button_image.png",
                  height: 200,
                ),
                text: const Text(
                  "Character Creator",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                textPadding: 50,
              ),
            ),
            characterController.when(
                data: (List<Character> characters) => Column(
                      children: [CharacterList(characters: characters)],
                    ),
                error: (e, st) {
                  if (kDebugMode) {
                    print(e);
                    print(st);
                  }
                  return const Text("Your characters could not be loaded");
                },
                loading: () => const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
