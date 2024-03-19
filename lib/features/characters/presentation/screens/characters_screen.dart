import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

import '../../../../routing/app_router.dart';

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
                image: const Image(
                  image: Svg("assets/images/character_creator_button_image.svg"),
                  height: 200,
                ),
                text: const Text(
                  "Character Creator",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                ),
                textPadding: 50,
              ),
            ),
            characterController.when(
                data: (characters) => Column(
                      children: [
                        ...characters.map(
                          (character) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: BoxShadowImage(
                              text: Text(
                                character.name ??
                                    "Character #${characters.indexOf(character)}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              height: 100,
                              width: 300,
                              textPadding: 25,
                              onTap: () {} // TODO Handle navigation,
                            ),
                          ),
                        )
                      ],
                    ),
                error: (_, __) =>
                    const Text("Your characters could not be loaded"),
                loading: () => const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
