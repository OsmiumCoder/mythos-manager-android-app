import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/character_display/features_list_card.dart';

class FeaturesList extends ConsumerWidget {
  const FeaturesList({
    super.key,
    required this.className,
    required this.subclass,
  });

  final String className;
  final String subclass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "Class Features",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(className, style: const TextStyle(fontSize: 16))
                ],
              ),
            )),
        FutureBuilder(
          future: ref
              .watch(dndApiController)
              .getClassFeatures(className.toLowerCase()),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List features = snapshot.data ?? [];
              return FeaturesListCard(features: features);
            } else {
              return Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const CircularProgressIndicator());
            }
          },
        ),
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "Subclass Features",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "$subclass Subclass",
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            )),
        FutureBuilder(
          future: ref
              .watch(dndApiController)
              .getSubclassFeatures(subclass.toLowerCase()),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List features = snapshot.data!;
              return FeaturesListCard(features: features);
            } else {
              return Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
