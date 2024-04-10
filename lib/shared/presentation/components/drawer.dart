import 'package:flutter/material.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Liam Welsh
class MythosDrawer extends Drawer {
  final String selectedScreen;

  const MythosDrawer({super.key, required this.selectedScreen});

  _handleRouting(BuildContext context, String routeName) {
    if (routeName == selectedScreen) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamed(context, routeName);
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
              color:
                  selectedScreen == AppRouter.homeScreen ? selectedColor : null,
              child: ListTile(
                leading: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                title:
                    const Text("Home", style: TextStyle(color: Colors.white)),
                onTap: () => _handleRouting(context, AppRouter.homeScreen),
              ),
            ),
            Container(
              color: selectedScreen == AppRouter.charactersScreen
                  ? selectedColor
                  : null,
              child: ListTile(
                leading: const Icon(
                  Icons.people_outline,
                  color: Colors.white,
                ),
                title: const Text(
                  "Characters",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () =>
                    _handleRouting(context, AppRouter.charactersScreen),
              ),
            ),
            Container(
              color: selectedScreen == AppRouter.campaignListScreen
                  ? selectedColor
                  : null,
              child: ListTile(
                leading: const Icon(
                  Icons.event_note_outlined,
                  color: Colors.white,
                ),
                title: const Text("Campaigns",
                    style: TextStyle(color: Colors.white)),
                onTap: () =>
                    _handleRouting(context, AppRouter.campaignListScreen),
              ),
            ),
            Container(
              color: selectedScreen == AppRouter.publicCharactersScreen
                  ? selectedColor
                  : null,
              child: ListTile(
                leading: const Icon(
                  Icons.store_outlined,
                  color: Colors.white,
                ),
                title: const Text("Public Characters",
                    style: TextStyle(color: Colors.white)),
                onTap: () =>
                    _handleRouting(context, AppRouter.publicCharactersScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
