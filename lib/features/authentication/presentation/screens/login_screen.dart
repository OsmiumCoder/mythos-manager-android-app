import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/presentation/controllers/authentication_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Login screen.
///
/// Author: Jonathon Meney
class LoginScreen extends HookConsumerWidget {
  static const String loginButtonText = "Login";
  static const String signUpButtonText = "Don't have an account?\nSign Up";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailTextController =
        useTextEditingController();
    final TextEditingController passwordTextController =
        useTextEditingController();

    ref.listen(authenticationStateProvider, (_, state) {
      if (state.value != null) {
        Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
      }
    });

    ref.listen(
        authenticationControllerProvider,
        (_, state) => state.whenOrNull(
              error: (error, stack) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                        content: Text(error.toString()),
                      );
                    });
              },
            ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: emailTextController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  child: const Text(
                    loginButtonText,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    ref.read(authenticationControllerProvider.notifier).login(
                        email: emailTextController.text,
                        password: passwordTextController.text);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      signUpButtonText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouter.signupScreen);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
