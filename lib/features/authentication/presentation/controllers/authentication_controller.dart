import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/application/authentication_service.dart';

final authenticationControllerProvider =
    AsyncNotifierProvider<AuthenticationController, void>(() {
  return AuthenticationController();
});

class AuthenticationController extends AsyncNotifier<void> {
  @override
  FutureOr build() {}

  Future<void> signUpAndLogin(
      {required String username,
      required String email,
      required String password}) async {
    final AuthenticationService authenticationService =
        ref.watch(authenticationServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authenticationService.signUpAndLogin(
        username: username, email: email, password: password));
  }

  Future<void> login({required String email, required String password}) async {
    final AuthenticationService authenticationService =
        ref.watch(authenticationServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authenticationService.login(email: email, password: password));
  }

  Future<void> signOut() async {
    final AuthenticationService authenticationService =
        ref.watch(authenticationServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authenticationService.signOut());
  }
}
