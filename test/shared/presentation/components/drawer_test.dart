import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

/// Author: Liam Welsh
void main() {
  group("MythosDrawer Test", () {
    testWidgets("Selecting menu icon opens drawer", (tester) async {
      await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text("Test"),
              ),
              drawer: const MythosDrawer(selectedScreen: AppRouter.homeScreen),
            ),
        )
      );

      final leadingIconFinder = find.widgetWithIcon(IconButton, Icons.menu);

      expect(leadingIconFinder, findsOne);

      final gesture = await tester.startGesture(tester.getCenter(leadingIconFinder));

      await gesture.up();

      await tester.pump();

      expect(find.byType(Drawer), findsOne);
    });
  });
}
