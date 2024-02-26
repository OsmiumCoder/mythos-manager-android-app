import 'package:flutter/material.dart';
import 'package:mythos_manager/shared/presentation/components/box_shadow_image.dart';

const placeHolderImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Donald_Trump_official_portrait.jpg/640px-Donald_Trump_official_portrait.jpg";

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BoxShadowImage(
              image: Image.network(placeHolderImage, width: 350, height: 200),
              text: Text(
                  "Campaigns",
                  textAlign: TextAlign.center,
                  style: cardTextStyle.copyWith(fontSize: 40),
              ),
              onTap: () {}, // TODO onTap Handler for navigation
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxShadowImage(
                  image: Image.network(placeHolderImage, width: 150, height: 200),
                  text: Text(
                      "Favourite Character",
                      textAlign: TextAlign.center,
                      style: cardTextStyle.copyWith(fontSize: 30),
                  ),
                  onTap: () {}, // TODO onTap Handler for navigation
              ),
              BoxShadowImage(
                  image: Image.network(placeHolderImage, width: 150, height: 200),
                  text: Text(
                      "Current Campaign",
                      textAlign: TextAlign.center,
                      style: cardTextStyle.copyWith(fontSize: 30),
                  ),
                  onTap: () {}, // TODO onTap Handler for navigation

              ),
            ],
          ),
          BoxShadowImage(
              image: Image.network(placeHolderImage, width: 350, height: 200),
              text: Text(
                "Character Creator",
                textAlign: TextAlign.center,
                style: cardTextStyle.copyWith(fontSize: 40),
              ),
              onTap: () {}, // TODO onTap Handler for navigation
          ),
        ],
      ),
    );
  }
}
