import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';
import 'package:mythos_manager/features/home/presentation/screens/screens.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockUser extends Mock implements User {}

void main() {
  group("AppRouter tests", () {
    final mockUser = MockUser();

    testWidgets('Navigating to homeScreen while no user shows SignUpScreen',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(ProviderScope(
          child: MaterialApp(
            initialRoute: AppRouter.homeScreen,
            onGenerateRoute: (settings) {
              return AppRouter.generateRoute(settings, null);
            },
          ),
        ));

        expect(find.byType(SignUpScreen), findsOneWidget);
      });
    });

    testWidgets('Navigating to homeScreen shows HomeScreen',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
          initialRoute: AppRouter.homeScreen,
          onGenerateRoute: (settings) {
            return AppRouter.generateRoute(settings, mockUser);
          },
        ));

        expect(find.byType(HomeScreen), findsOneWidget);
      });
    });

    testWidgets('Navigating to loginScreen shows LoginScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          onGenerateRoute: (settings) {
            return AppRouter.generateRoute(settings, mockUser);
          },
          initialRoute: AppRouter.loginScreen,
        ),
      ));

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('Navigating to signupScreen shows SignUpScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          onGenerateRoute: (settings) {
            return AppRouter.generateRoute(settings, mockUser);
          },
          initialRoute: AppRouter.signupScreen,
        ),
      ));

      expect(find.byType(SignUpScreen), findsOneWidget);
    });
  });
}
