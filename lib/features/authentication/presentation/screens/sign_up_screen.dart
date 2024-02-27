import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Sign Up screen.
///
/// Author: Jonathon Meney
class SignUpScreen extends HookConsumerWidget {
  static const String signUpButtonText = "Sign Up";
  static const String loginButtonText = "Already have an account?\nLogin";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameTextController =
        useTextEditingController();
    final TextEditingController emailTextController =
        useTextEditingController();
    final TextEditingController passwordTextController =
        useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                controller: usernameTextController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
            ),
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
                    signUpButtonText,
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
                      loginButtonText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    // TODO: send to login route
                    // Navigator.pushReplacementNamed(context, 'routeName');
                  }),
            )
          ],
        ),
      ),
    );
  }
}
