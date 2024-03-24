import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/presentation/components/components.dart';
import '../../../characters/presentation/controllers/character_builder_controller.dart';

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
                  image: const Image(
                      image: Svg("assets/images/campaign_button_image.svg"),
                      height: 200),
                  text: Text(
                    "Campaigns",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 70,
                  onTap: () => Navigator.pushNamed(context, AppRouter.campaignListScreen),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: const Image(
                      image: Svg("assets/images/characters_button_image.svg"),
                      height: 200),
                  text: Text(
                    "Characters",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 70,
                  onTap: () => Navigator.pushNamed(context, AppRouter.campaignListScreen),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: const Image(
                    image:
                        Svg("assets/images/character_creator_button_image.svg"),
                    height: 200,
                  ),
                  text: Text(
                    "Character Creator",
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
