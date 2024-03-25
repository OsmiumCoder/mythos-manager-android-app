import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/presentation/controllers/authentication_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/features/characters/presentation/screens/components/components.dart';

import '../../domain/character.dart';

/// Author Liam Welsh
class CharacterDisplayScreen extends HookConsumerWidget {
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
        return MainCharacterDisplay(character: character);
      case 1:
        return CharacterSpellDisplay(className: character.className!);
      case 2:
        return const Text(
            "Backstory screen"); // TODO implement backstory screen
      default:
        return const Text("Unknown Character Screen");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPublic = useState(character.isPublic);

    final user = ref.watch(authenticationControllerProvider.notifier).getUser();

    final isUsersCharacter = character.userID == user?.uid;

    final selectedScreen = useState(0);

    togglePublicVisibility() {
      character.isPublic = !character.isPublic;
      isPublic.value = !isPublic.value;
      ref.read(characterControllerProvider.notifier).updateCharacter(character);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(selectedScreen.value)),
        actions: [
          if (isUsersCharacter)
            IconButton(
                onPressed: () {
                  togglePublicVisibility();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "Character has been made ${isPublic.value ? "public" : "private"}"),
                      TextButton(
                        child: const Text("Undo"),
                        onPressed: () {
                          togglePublicVisibility();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      )
                    ],
                  )));
                },
                tooltip: "Toggle public visibility",
                icon: Icon(isPublic.value ? Icons.share_outlined : Icons.share,
                    size: 30,
                    color: isPublic.value
                        ? const Color(0xabd3d3d3)
                        : Colors.black))
        ],
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
