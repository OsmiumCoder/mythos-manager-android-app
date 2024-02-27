import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                  child: Text(
                    loginButtonText,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    // TODO: wire together to auth controller
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      signUpButtonText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    // TODO: send to sign up route
                    // Navigator.pushReplacementNamed(context, 'routeName');
                  }),
            )
          ],
        ),
      ),
    );
  }
}
