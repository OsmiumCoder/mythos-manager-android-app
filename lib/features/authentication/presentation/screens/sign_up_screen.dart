import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/presentation/controllers/authentication_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';

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

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username required';
                      }
                      return null;
                    },
                    controller: usernameTextController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                    controller: emailTextController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      return null;
                    },
                    controller: passwordTextController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      child: const Text(
                        signUpButtonText,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authenticationControllerProvider.notifier)
                              .signUpAndLogin(
                                  username: usernameTextController.text,
                                  email: emailTextController.text,
                                  password: passwordTextController.text);
                        }
                      }),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          loginButtonText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRouter.loginScreen);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
