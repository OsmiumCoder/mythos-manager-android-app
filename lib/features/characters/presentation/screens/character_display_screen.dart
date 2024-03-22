import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CharacterDisplayScreen extends HookWidget {
  const CharacterDisplayScreen({super.key});

  String _getTitle(int selectedScreen) {
    if (selectedScreen == 0) {
      return "Character";
    }
    if (selectedScreen == 1) {
      return "Spells";
    }
    if (selectedScreen == 2) {
      return "Backstory";
    }
    
    return "Unknown Screen";
  }
  
  Widget _getSelectedScreen(int selectedScreen) {
    if (selectedScreen == 0) {
      return const Text("Character screen"); // TODO implement character screen
    }
    if (selectedScreen == 1) {
      return const Text("Spells screen"); // TODO implement spells screen
    }
    if (selectedScreen == 2) {
      return const Text("Backstory screen"); // TODO implement backstory screen
    }

    return const Text("Unknown Character Screen");
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
