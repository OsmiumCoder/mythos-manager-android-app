import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

/// Home screen.
///
/// Author: Liam Welsh
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  final cardTextStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mythos Manager"),
        centerTitle: true,
      ),
      drawer: const MythosDrawer(
        selectedScreen: AppRouter.homeScreen,
      ),
      body: Container(
        margin: const EdgeInsets.all(35),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: Image.asset(
                    "assets/images/campaign_button_image.png",
                    height: 200,
                    width: 290,
                  ),
                  text: Text(
                    "Campaigns",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 70,
                  onTap: () => Navigator.pushNamed(
                      context, AppRouter.campaignListScreen),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: Image.asset(
                    "assets/images/characters_button_image.png",
                    height: 200,
                    width: 290,
                  ),
                  text: Text(
                    "Characters",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 70,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouter.charactersScreen),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: Image.asset(
                    "assets/images/character_creator_button_image.png",
                    height: 200,
                    width: 290,
                  ),
                  text: Text(
                    "Character\nCreator",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 50,
                  onTap: () {
                    // Reset character creation state
                    ref.read(characterBuilderProvider.notifier).state =
                        CharacterBuilderController();
                    Navigator.pushNamed(context, AppRouter.raceSelectionScreen);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
