import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';

// Author: Jonathon Meney
void main() {
  group('sign up screen widget tests', () {
    testWidgets('SignUpScreen has three text fields', (widgetTester) async {
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));

      final textFields = find.byType(TextField);

      expect(textFields, findsNWidgets(3));
    });

    testWidgets('SignUpScreen has two elevated buttons fields',
        (widgetTester) async {
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));

      final textFields = find.byType(ElevatedButton);

      expect(textFields, findsNWidgets(2));
    });

    testWidgets(
        'SignUpScreen has username, email, and password labeled text fields',
        (widgetTester) async {
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));

      final usernameLabel = find.bySemanticsLabel('Username');
      final emailLabel = find.bySemanticsLabel('Email');
      final passwordLabel = find.bySemanticsLabel('Password');

      expect(usernameLabel, findsOneWidget);
      expect(emailLabel, findsOneWidget);
      expect(passwordLabel, findsOneWidget);
    });

    testWidgets('SignUpScreen has correct button texts', (widgetTester) async {
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));

      final loginButton =
          find.widgetWithText(ElevatedButton, SignUpScreen.signUpButtonText);
      final signUpButton =
          find.widgetWithText(ElevatedButton, SignUpScreen.loginButtonText);

      expect(loginButton, findsOneWidget);
      expect(signUpButton, findsOneWidget);
    });
  });
}
