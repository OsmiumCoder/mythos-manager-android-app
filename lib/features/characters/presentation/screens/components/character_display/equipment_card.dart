import 'package:flutter/material.dart';

class EquipmentCard extends StatelessWidget {
  const EquipmentCard({
    super.key,
    required this.equipment,
  });

  final Set<String>? equipment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Equipment",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              subtitle: Text(equipment?.join("\n") ?? ""),
              subtitleTextStyle: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
