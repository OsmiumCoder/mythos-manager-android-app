import 'package:flutter/material.dart';

class ProficienciesCard extends StatelessWidget {
  const ProficienciesCard({
    super.key,
    this.skillProficiencies,
    this.equipmentProficiencies,
  });

  final Set<String>? skillProficiencies;
  final Set<String>? equipmentProficiencies;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Proficiencies",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              subtitle: Text(
                  "Skills:\n${skillProficiencies?.join("\n") ?? ""}\n\nEquipment:\n${equipmentProficiencies?.join("\n") ?? ""}"),
              subtitleTextStyle: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
