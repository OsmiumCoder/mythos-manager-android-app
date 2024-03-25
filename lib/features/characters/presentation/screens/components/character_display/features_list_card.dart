import 'package:flutter/material.dart';

/// Author: Jonathon Meney
class FeaturesListCard extends StatelessWidget {
  const FeaturesListCard({
    super.key,
    required this.features,
  });

  final List features;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> feature = features[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "${feature["name"]}, Level ${feature["level"]}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Text(
                  feature["desc"].join("\n\n"),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        });
  }
}
