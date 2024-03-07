import 'package:flutter/material.dart';

import '../../../routing/app_router.dart';

/// Author: Liam Welsh
class MythosDrawer extends Drawer {
  final String selectedScreen;
  const MythosDrawer({super.key, required this.selectedScreen});


  _handleRouting(BuildContext context, String routeName) {
    if (routeName == selectedScreen) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).appBarTheme.backgroundColor;
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
          child: ListView(
            padding: const EdgeInsets.only(top: 30),
            children: [
              Container(
                color: selectedScreen == AppRouter.homeScreen ? selectedColor : null,
                child: ListTile(
                  leading: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  title: const Text("Home", style: TextStyle(color: Colors.white)),
                  onTap: () => _handleRouting(context, AppRouter.homeScreen),
                ),
              ),
              Container(
                color: selectedScreen == AppRouter.charactersScreen ? selectedColor : null, // TODO implement color when current route is character,
                child: ListTile(
                  leading: const Icon(
                    Icons.people_outline,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Characters",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => _handleRouting(context, AppRouter.charactersScreen), // TODO implement routing
                ),
              ),
              Container(
                color: null, // TODO implement color when current route is campaigns,
                child: ListTile(
                  leading: const Icon(
                    Icons.event_note_outlined,
                    color: Colors.white,
                  ),
                  title:
                  const Text("Campaigns", style: TextStyle(color: Colors.white)),
                  onTap: () {}, // TODO implement routing
                ),
              ),
              Container(
                color: null, // TODO implement color when current route is publicCharacters,
                child: ListTile(
                  leading: const Icon(
                    Icons.store_outlined,
                    color: Colors.white,
                  ),
                  title: const Text("Public Characters",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {}, // TODO implement routing
                ),
              ),
              Container(
                color: null, // TODO implement color when current route is Homebrew,
                child: ListTile(
                  leading: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  title:
                  const Text("Homebrew", style: TextStyle(color: Colors.white)),
                  onTap: () {}, // TODO implement routing
                ),
              ),
            ],
          ),
        ),
    );

  }
}
