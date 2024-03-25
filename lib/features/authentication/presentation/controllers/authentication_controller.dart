import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/application/authentication_service.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

/// Provides an [AuthenticationController].
final authenticationControllerProvider =
AsyncNotifierProvider<AuthenticationController, void>(() {
  return AuthenticationController();
});

/// Controls all delegation of auth requests.
///
/// Author: Jonathon Meney
class AuthenticationController extends AsyncNotifier<void> {
  @override
  FutureOr build() {}

  /// Signs up a new user with the given username, email, and password.
  ///
  /// After a user as been created they will also be logged in.
  Future<void> signUpAndLogin(
      {required String username,
      required String email,
      required String password}) async {
    final AuthenticationService authenticationService =
        ref.read(authenticationServiceProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authenticationService.signUpAndLogin(
        username: username, email: email, password: password));
  }

  /// Attempts to login a user with the given email and password.
  Future<void> login({required String email, required String password}) async {
    final AuthenticationService authenticationService =
        ref.read(authenticationServiceProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authenticationService.login(email: email, password: password));
  }

  /// Signs out the currently signed in user.
  Future<void> signOut() async {
    final AuthenticationService authenticationService =
        ref.read(authenticationServiceProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authenticationService.signOut());
  }

  /// Returns the currently signed in [User].
  ///
  /// If no user is signed in null will be returned.
  User? currentUser() {
    return ref.read(authenticationServiceProvider).currentUser();
  }
}
