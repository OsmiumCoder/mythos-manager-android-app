import 'package:flutter/material.dart';

class RacialTraitCard extends StatelessWidget {
  const RacialTraitCard({
    super.key,
    required this.racialTraits,
  });

  final Set<String>? racialTraits;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Racial Traits",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              subtitle: Text(racialTraits?.join("\n") ?? ""),
              subtitleTextStyle: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
