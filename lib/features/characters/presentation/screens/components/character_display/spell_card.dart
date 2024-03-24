import 'package:flutter/material.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.spell,
  });

  final Map<String, dynamic> spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(spell["name"],
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spell["level"] == 0 ? "Cantrip" : "Level ${spell["level"]}",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text("Casting Time: ${spell["casting_time"]}"),
              Text("Duration: ${spell["duration"]}"),
              Text("Range: ${spell["range"]}"),
              Text(
                  "Components: ${spell["components"].join(", ")} ${spell["material"] ?? ""}\n"),
              Text(spell["desc"].join("\n\n")),
              Text(spell["higher_level"].join("\n\n"))
            ],
          ),
          subtitleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
