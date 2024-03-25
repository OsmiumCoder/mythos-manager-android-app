import 'package:flutter/material.dart';

/// Author: Jonathon Meney
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
    List<String> skills = skillProficiencies?.map((skill) {
          return skill.split(" ")[1];
        }).toList() ??
        [];
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
                  "Skills:\n${skills.join("\n")}\n\nEquipment:\n${equipmentProficiencies?.join("\n") ?? ""}"),
              subtitleTextStyle: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
