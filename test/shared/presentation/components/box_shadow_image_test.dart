import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/shared/presentation/components/box_shadow_image.dart';
import 'package:network_image_mock/network_image_mock.dart';

// Author: Liam Welsh
void main() {
  group("BoxShadowImageTest", () {
    testWidgets("Test onTapDown changes border to black with no opacity",
        (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(BoxShadowImage(
          image: Image.network(
            "",
            height: 100,
            width: 100,
          ),
          text: const Text(
            "Text",
            textDirection: TextDirection.ltr,
          ))));

      final boxShadowFinder = find.byType(BoxShadowImage);

      expect(boxShadowFinder, findsOneWidget);

      await tester.pumpAndSettle();
      await tester.startGesture(tester.getCenter(boxShadowFinder));

      await tester.pump();

      final containerFinder = find.byKey(const Key("BoxShadowContainer"));

      final decoration =
          tester.widget<Container>(containerFinder).decoration as BoxDecoration;

      final BoxShadow boxShadow = decoration.boxShadow![0];

      expect(boxShadow.color, BoxShadowImage.boxShadowColor);
    });

    testWidgets("Test onTapUp changes back to original boxShadow color",
        (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(BoxShadowImage(
          image: Image.network(
            "",
            height: 100,
            width: 100,
          ),
          text: const Text(
            "Text",
            textDirection: TextDirection.ltr,
          ))));

      final boxShadowFinder = find.byType(BoxShadowImage);

      final prevContainerFinder = find.byKey(const Key("BoxShadowContainer"));

      final prevDecoration = tester
          .widget<Container>(prevContainerFinder)
          .decoration as BoxDecoration;

      final BoxShadow prevBoxShadow = prevDecoration.boxShadow![0];

      final gesture =
          await tester.startGesture(tester.getCenter(boxShadowFinder));

      await gesture.up();

      await tester.pump();

      final containerFinder = find.byKey(const Key("BoxShadowContainer"));

      final decoration =
          tester.widget<Container>(containerFinder).decoration as BoxDecoration;

      final BoxShadow boxShadow = decoration.boxShadow![0];

      expect(boxShadow.color, prevBoxShadow.color);
    });
  });
}
