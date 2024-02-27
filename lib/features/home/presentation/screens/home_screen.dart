import 'package:flutter/material.dart';
import 'package:mythos_manager/shared/presentation/components/box_shadow_image.dart';

const placeHolderImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Donald_Trump_official_portrait.jpg/640px-Donald_Trump_official_portrait.jpg";

/// Home screen.
///
/// Author: Liam Welsh
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final cardTextStyle = const TextStyle(
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mythos Manager"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(35),

        child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BoxShadowImage(
                      image: Image.network(placeHolderImage, height: 200),
                      text: Text(
                          "Campaigns",
                          textAlign: TextAlign.center,
                          style: cardTextStyle,
                      ),
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
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: BoxShadowImage(
                            image: Image.network(placeHolderImage, height: 300,),
                            text: Text(
                                "Favourite\nCharacter",
                                textAlign: TextAlign.center,
                                style: cardTextStyle,
                            ),
                            onTap: () {}, // TODO onTap Handler for navigation
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: BoxShadowImage(
                            image: Image.network(placeHolderImage, height: 300,),
                            text: Text(
                                "Current\nCampaign",
                                textAlign: TextAlign.center,
                                style: cardTextStyle,
                            ),
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
                      image: Image.network(placeHolderImage),
                      text: Text(
                        "Character Creator",
                        textAlign: TextAlign.center,
                        style: cardTextStyle,
                      ),
                      onTap: () {}, // TODO onTap Handler for navigation
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
