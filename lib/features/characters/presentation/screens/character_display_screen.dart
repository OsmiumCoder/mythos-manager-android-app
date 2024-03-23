import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/components.dart';

import '../../domain/character.dart';

/// Author Liam Welsh
class CharacterDisplayScreen extends HookWidget {
  final Character character;
  const CharacterDisplayScreen({super.key, required this.character});

  String _getTitle(int selectedScreen) {
    switch (selectedScreen) {
      case 0:
        return character.name ?? "Character Name";
      case 1:
        return "Spells";
      case 2:
        return "Backstory";
      default:
        return "Unknown Screen";
    }
  }
  
  Widget _getSelectedScreen(int selectedScreen) {
    switch (selectedScreen) {
      case 0:
        return MainCharacterDisplayScreen(character: character);
      case 1:
        return const Text("Spells screen"); // TODO implement spells screen
      case 2:
        return const Text("Backstory screen"); // TODO implement backstory screen
      default:
        return const Text("Unknown Character Screen");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedScreen = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(selectedScreen.value)),
        centerTitle: true,
      ),

      body: _getSelectedScreen(selectedScreen.value),
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedScreen.value,
          onDestinationSelected: (index) => selectedScreen.value = index,
          backgroundColor: Theme.of(context).primaryColor,

          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_2_outlined),
              label: "Character",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.local_fire_department),
              icon: Icon(Icons.local_fire_department_outlined),
              label: "Spells",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.book),
              icon: Icon(Icons.book_outlined),
              label: "Backstory",
            ),
          ]),
    );
  }
}
