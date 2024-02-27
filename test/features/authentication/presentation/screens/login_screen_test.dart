import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';

// Author: Jonathon Meney
void main() {
  group('login screen widget tests', () {
    testWidgets('LoginScreen has two text fields', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final textFields = find.byType(TextField);

      expect(textFields, findsNWidgets(2));
    });

    testWidgets('LoginScreen has two elevated buttons fields',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final textFields = find.byType(ElevatedButton);

      expect(textFields, findsNWidgets(2));
    });

    testWidgets('LoginScreen has email and password labeled text fields',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final emailLabel = find.bySemanticsLabel('Email');
      final passwordLabel = find.bySemanticsLabel('Password');

      expect(emailLabel, findsOneWidget);
      expect(passwordLabel, findsOneWidget);
    });

    testWidgets('LoginScreen has correct button texts', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final loginButton =
          find.widgetWithText(ElevatedButton, LoginScreen.loginButtonText);
      final signUpButton =
          find.widgetWithText(ElevatedButton, LoginScreen.signUpButtonText);

      expect(loginButton, findsOneWidget);
      expect(signUpButton, findsOneWidget);
    });
  });
}
