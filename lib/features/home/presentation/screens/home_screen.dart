import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/presentation/components/components.dart';
import '../../../character_creator/domain/character.dart';
import '../../../character_creator/presentation/controllers/character_creation_controller.dart';

const placeHolderImage =
     "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Donald_Trump_official_portrait.jpg/640px-Donald_Trump_official_portrait.jpg";

/// Home screen.
///
/// Author: Liam Welsh
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  final cardTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

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
                  image: const Image(image: Svg("assets/images/campaign_button_image.svg"), height: 200),
                  text: Text(
                    "Campaigns",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 70,
                  onTap: () {}, // TODO onTap Handler for navigation
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: BoxShadowImage(
                        image: Image.network(placeHolderImage, height: 200,),
                        text: Text(
                          "Favourite\nCharacter",
                          textAlign: TextAlign.center,
                          style: cardTextStyle,
                        ),
                        textPadding: 30,
                        onTap: () {}, // TODO onTap Handler for navigation
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: BoxShadowImage(
                        image: const Image(image: Svg("assets/images/current_campaign_button_image.svg"), height: 200),
                        text: Text(
                          "Current\nCampaign",
                          textAlign: TextAlign.center,
                          style: cardTextStyle,
                        ),
                        textPadding: 30,
                        onTap: () {}, // TODO onTap Handler for navigation
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BoxShadowImage(
                  image: const Image(image: Svg("assets/images/character_creator_button_image.svg"), height: 200, ),
                  text: Text(
                    "Character Creator",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  ),
                  textPadding: 50,
                  onTap: () {
                    // Reset character creation state
                    ref.read(characterCreationProvider.notifier).state = Character();
                    Navigator.of(context).pushNamed(AppRouter.raceSelectionScreen);
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
