import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';
import 'package:mythos_manager/features/home/presentation/screens/screens.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:network_image_mock/network_image_mock.dart';


void main() {
  testWidgets('Navigating to homeScreen shows HomeScreen', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.homeScreen,
      ));

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  testWidgets('Navigating to loginScreen shows LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.loginScreen,
    ));

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Navigating to signupScreen shows SignUpScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.signupScreen,
    ));

    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}

