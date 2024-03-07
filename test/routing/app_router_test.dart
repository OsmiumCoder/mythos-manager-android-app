import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/screens.dart';
import 'package:mythos_manager/features/home/presentation/screens/screens.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockUser extends Mock implements User {}

class MockWidgetRef extends Mock implements WidgetRef {}

void main() {
  group("AppRouter tests", () {
    testWidgets('Navigating to homeScreen while no user shows SignUpScreen',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        WidgetRef ref = MockWidgetRef();

        when(() => ref.read(authenticationStateProvider))
            .thenReturn(const AsyncData(null));

        await tester.pumpWidget(ProviderScope(
          child: MaterialApp(
            initialRoute: AppRouter.homeScreen,
            onGenerateRoute: (settings) {
              return AppRouter.generateRoute(settings, ref);
            },
          ),
        ));

        expect(find.byType(SignUpScreen), findsOneWidget);
      });
    });

    testWidgets('Navigating to homeScreen shows HomeScreen',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        WidgetRef ref = MockWidgetRef();

        when(() => ref.read(authenticationStateProvider))
            .thenReturn(AsyncData(MockUser()));

        await tester.pumpWidget(ProviderScope(
          child: MaterialApp(
            initialRoute: AppRouter.homeScreen,
            onGenerateRoute: (settings) {
              return AppRouter.generateRoute(settings, ref);
            },
          ),
        ));

        expect(find.byType(HomeScreen), findsOneWidget);
      });
    });

    testWidgets('Navigating to loginScreen shows LoginScreen',
        (WidgetTester tester) async {
      WidgetRef ref = MockWidgetRef();

      when(() => ref.read(authenticationStateProvider))
          .thenReturn(AsyncData(MockUser()));

      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          onGenerateRoute: (settings) {
            return AppRouter.generateRoute(settings, ref);
          },
          initialRoute: AppRouter.loginScreen,
        ),
      ));

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('Navigating to signupScreen shows SignUpScreen',
        (WidgetTester tester) async {
      WidgetRef ref = MockWidgetRef();

      when(() => ref.read(authenticationStateProvider))
          .thenReturn(AsyncData(MockUser()));

      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          onGenerateRoute: (settings) {
            return AppRouter.generateRoute(settings, ref);
          },
          initialRoute: AppRouter.signupScreen,
        ),
      ));

      expect(find.byType(SignUpScreen), findsOneWidget);
    });

    testWidgets('Navigating to raceSelectionScreen shows RaceSelectionScreen',
            (WidgetTester tester) async {
          WidgetRef ref = MockWidgetRef();

          when(() => ref.read(authenticationStateProvider))
              .thenReturn(AsyncData(MockUser()));

          await tester.pumpWidget(ProviderScope(
            child: MaterialApp(
              onGenerateRoute: (settings) {
                return AppRouter.generateRoute(settings, ref);
              },
              initialRoute: AppRouter.raceSelectionScreen,
            ),
          ));

          expect(find.byType(RaceSelectionScreen), findsOneWidget);
        });
  });
}
