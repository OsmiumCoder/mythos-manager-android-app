import 'package:flutter/material.dart';

/// Shreif Abdalla
class CharacterDetailCard extends StatelessWidget {
  final String title;
  final String content;
  final ThemeData theme;

  const CharacterDetailCard({
    super.key,
    required this.title,
    required this.content,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.cardTheme.color,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
