import 'package:flutter/material.dart';

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
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        subtitle: Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
