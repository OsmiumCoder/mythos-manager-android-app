import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

import '../../../../routing/app_router.dart';

/// Author: Liam Welsh
class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        centerTitle: true,
      ),
      drawer: const MythosDrawer(
        selectedScreen: AppRouter.charactersScreen,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(35),
            child: BoxShadowImage(
                onTap: () {}, // TODO add routing
                image: const Image(
                  image:
                      Svg("assets/images/character_creator_button_image.svg"),
                  height: 200,
                ),
                text: const Text("Character Creator", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                textPadding: 50,
            ),
          ),
        ],
      ),
    );
  }
}
